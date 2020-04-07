#!/bin/sh
#
# Start a GKE cluster with istio and kubernetes alpha features enabled

error()
{
    echo "$0: Error: $*" >&2
    exit 1
}

CLUSTER_NAME=${CLUSTER_NAME:-"test-cluster"}
PROJECT=${PROJECT:-"$(gcloud config get-value core/project 2>/dev/null)"}
REGION=${REGION:-"$(gcloud config get-value compute/region --project=${PROJECT} 2>/dev/null)"}
CLUSTER_VERSION=${CLUSTER_VERSION:-"$(gcloud container get-server-config --region=${REGION} --project=${PROJECT} --format='value(validNodeVersions[0])' 2>/dev/null)"}
INITIAL_NODES=${INITIAL_NODES:-3}
MIN_NODES=${MIN_NODES:-1}
MAX_NODES=${MAX_NODES:-100}
DISK_SIZE=${DISK_SIZE:-20}
# List of roles to add to service account
ROLES=${ROLES:-"roles/logging.logWriter roles/monitoring.metricWriter roles/monitoring.viewer roles/container.admin"}
# Comma-separated list of Kubernetes addons to enable
ADDONS=${ADDONS:-"HttpLoadBalancing,HorizontalPodAutoscaling"}
NETWORK_NAME=${NETWORK_NAME:-"${CLUSTER_NAME}"}
SUBNET_NAME=${SUBNET_NAME:-"${NETWORK_NAME}"}

# Find a 'shuf' option
which -s ruby && SHUF='ruby -e "puts STDIN.readlines.shuffle"'
which -s gshuf && SHUF=gshuf
which -s shuf && SHUF=shuf

# Validate!
which -s istioctl || error "Can't find istioctl executable"
which -s kubectl || error "Can't find kubectl executable"
which -s gcloud || error "Can't find gcloud executable"
which -s awk || error "Can't find awk executable"
which -s dirname || error "Can't find dirname executable"
[ -n "${SHUF}" ] || error "Can't find a shuffle option"

# Get zones based on region
_ZONES=$(gcloud compute zones list --filter="region:${REGION}" \
    --project=${PROJECT} | eval ${SHUF} | \
    awk '/UP$/ {printf "%s%s",comma,$1; comma=","}')
_NUM_ZONES=$(echo $_ZONES | awk -F, '{print NF}')
_MAIN_ZONE=${_ZONES%%,*}

# Adjust for number of zones
_INITIAL_NODES_PER_ZONE=$((${INITIAL_NODES} / ${_NUM_ZONES}))
[ -z "${_INITIAL_NODES_PER_ZONE}" -o "${_INITIAL_NODES_PER_ZONE}" = "0" ] && \
    _INITIAL_NODES_PER_ZONE="1"
_MIN_NODES_PER_ZONE=$((${MIN_NODES} / ${_NUM_ZONES}))
[ -z "${_MIN_NODES_PER_ZONE}" -o "${_MIN_NODES_PER_ZONE}" = "0" ] && \
    _MIN_NODES_PER_ZONE="1"
_MAX_NODES_PER_ZONE=$((${MAX_NODES} / ${_NUM_ZONES} ))
[ -z "${_MAX_NODES_PER_ZONE}" -o "${_MAX_NODES_PER_ZONE}" = "0" ] && \
    _MAX_NODES_PER_ZONE="${_MIN_NODES_PER_ZONE}"

# Calculate CIDR ranges for nodes, pods and services
# Note: hard-coded for now
_NODE_CIDR="10.4.0.0/22"
_POD_CIDR="10.0.0.0/14"
_SERVICE_CIDR="10.4.4.0/22"

# Create a new service account for the cluster
gcloud iam service-accounts create ${CLUSTER_NAME} \
       --display-name="${CLUSTER_NAME}" \
       --project=${PROJECT} || \
    error "Unable to create new service account for ${CLUSTER_NAME}"

# Service account roles
for role in ${ROLES}
do
    gcloud projects add-iam-policy-binding ${PROJECT} \
        --member "serviceAccount:${CLUSTER_NAME}@${PROJECT}.iam.gserviceaccount.com" \
        --role ${role} || \
	error "Unable to bind role '${role}' to service account '${CLUSTER_NAME}'"
done

# Create a network for the cluster
gcloud compute networks create ${NETWORK_NAME} \
       --description="Network for ${CLUSTER_NAME}" \
       --subnet-mode=custom \
       --project=${PROJECT} || \
    error "Unable to create network ${NETWORK_NAME}"

# Create subnet for the cluster
gcloud beta compute networks subnets create ${SUBNET_NAME} \
       --description="Subnet for ${CLUSTER_NAME}" \
       --network=${NETWORK_NAME} \
       --range=${_NODE_CIDR} \
       --secondary-range=${CLUSTER_NAME}-pods=${_POD_CIDR},${CLUSTER_NAME}-services=${_SERVICE_CIDR} \
       --project=${PROJECT} || \
    error "Unable to create subnet ${SUBNET_NAME}"

# Create a cluster to contain node-pools using pre-emptible instances
gcloud beta container clusters create ${CLUSTER_NAME} \
    --quiet \
    --project ${PROJECT} \
    --service-account="${CLUSTER_NAME}@${PROJECT}.iam.gserviceaccount.com" \
    --preemptible \
    --zone=${_MAIN_ZONE} \
    --node-locations=${_ZONES} \
    --num-nodes=${_INITIAL_NODES_PER_ZONE} \
    ${_MIN_NODES_PER_ZONE:+"--min-nodes=${_MIN_NODES_PER_ZONE}"} \
    ${_MAX_NODES_PER_ZONE:+"--max-nodes=${_MAX_NODES_PER_ZONE}"} \
    ${USERNAME:+"--username=${USERNAME}"} \
    ${CLUSTER_VERSION:+"--cluster-version=${CLUSTER_VERSION}"} \
    ${MACHINE_TYPE:+"--machine-type=${MACHINE_TYPE}"} \
    ${IMAGE_TYPE:+"--image-type=${IMAGE_TYPE}"} \
    ${DISK_SIZE:+"--disk-size=${DISK_SIZE}"} \
    --network=${NETWORK_NAME} \
    --subnetwork=${SUBNET_NAME} \
    --enable-autoscaling \
    --enable-cloud-logging \
    --enable-cloud-monitoring \
    --enable-kubernetes-alpha \
    --enable-network-policy \
    --no-enable-legacy-authorization \
    --enable-ip-alias \
    --cluster-secondary-range-name=${CLUSTER_NAME}-pods \
    --services-secondary-range-name=${CLUSTER_NAME}-services \
    ${ADDONS:+"--addons=${ADDONS}"} || \
    error "Error creating cluster"

# Get kubeconfig for this cluster
gcloud container clusters get-credentials ${CLUSTER_NAME} \
    --zone ${_MAIN_ZONE} \
    --project ${PROJECT} || \
    error "Error getting kube context from GCP"

# Add RBAC role for istio
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user="$(gcloud config get-value core/account --project ${PROJECT} 2>/dev/null)" || \
    error "Error binding the account $(gcloud config get-value core/account --project ${PROJECT} 2>/dev/null) to cluster-admin role"
1
# Install istio to cluster
kubectl apply \
    -f $(dirname $(which istioctl))/../install/kubernetes/istio-demo-auth.yaml || \
    error "Error installing istio components"

# Add auto initialisers if supported
#kubectl api-versions | grep -q 'admissionregistration\.k8s\.io' && \
#    kubectl apply -f $(dirname $(which istioctl))/../install/kubernetes/istio-initializer.yaml || \
#    error "Error installing istio initialisers"

# Show the goods
kubectl get svc -n istio-system
kubectl get pods -n istio-system
