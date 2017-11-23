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
REGION=${REGION:-"$(gcloud config get-value compute/region 2>/dev/null)"}
INITIAL_NODES=${INITIAL_NODES:-3}
MIN_NODES=${MIN_NODES:-1}
MAX_NODES=${MAX_NODES:-100}
DISK_SIZE=${DISK_SIZE:-20}
# Comma-separated list of scopes, either aliases or full URIs
SCOPES=${SCOPES:-"default"}

# Find a 'shuf' option
which gshuf && SHUF=gshuf
which shuf && SHUF=shuf

# Validate!
which -s istioctl || error "Can't find istioctl executable"
which -s kubectl || error "Can't find kubectl executable"
which -s gcloud || error "Can't find gcloud executable"
which -s awk || error "Can't find awk executable"
which -s dirname || error "Can't find dirname executable"
[ -n "${SHUF}" ] || error "Can't find a shuffle option"

# Get zones based on region
_ZONES=$(gcloud compute zones list --filter="region:${REGION}" | eval ${SHUF} | \
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

# Create a cluster to contain node-pools using pre-emptible instances
gcloud beta container clusters create ${CLUSTER_NAME} \
    --quiet \
    --project ${PROJECT} \
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
    --network=${NETWORK:-default} \
    --subnetwork=${SUBNETWORK:-default} \
    ${SCOPES:+"--scopes=${SCOPES}"} \
    --enable-autoscaling \
    --enable-cloud-logging \
    --enable-cloud-monitoring \
    --enable-kubernetes-alpha \
    --no-enable-legacy-authorization || \
    error "Error creating cluster"

# Get kubeconfig for this cluster
gcloud container clusters get-credentials ${CLUSTER_NAME} \
    --zone ${_MAIN_ZONE} \
    --project ${PROJECT} || \
    error "Error getting kube context from GCP"

# Add RBAC role for istio
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user="$(gcloud config get-value core/account 2>/dev/null)" || \
    error "Error binding the account $(gcloud config get-value core/account 2>/dev/null) to cluster-admin role"

# Install istio to cluster
kubectl apply \
    -f $(dirname $(which istioctl))/../install/kubernetes/istio-auth.yaml || \
    error "Error installing istio components"

# Add auto initialisers if supported
kubectl api-versions | grep -q 'admissionregistration\.k8s\.io' && \
    kubectl apply -f $(dirname $(which istioctl))/../install/kubernetes/istio-initializer.yaml || \
    error "Error installing istio initialisers"

# Show the goods
kubectl get svc -n istio-system
kubectl get pods -n istio-system
