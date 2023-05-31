# Functions to parse GCP audit logs; those with leading underscore are intended
# to be used within the module only.

# Returns an uncollated list of individual permission/outcome/resource objects
# that satisfies the provided filter.
def _gcp_audit_log_entries(filter):
    map(select(.protoPayload.authorizationInfo)) |
    [
        .[] |
        .protoPayload.authorizationInfo |
        map(select(filter)) |
        map({permission: .permission, outcome: (if .granted then "allowed" else "denied" end), resource: .resourceAttributes.name})
    ] |
    add;

# Collate the output from _gcp_audit_log_entries to group by permission
def _gcp_audit_log_permissions(filter):
    _gcp_audit_log_entries(filter) |
    reduce .[] as $entry ({}; .[$entry.permission][$entry.outcome] |= (. + [$entry.resource] | unique));

# Collate the output from _gcp_audit_log_entries to group by resource
def _gcp_audit_log_resources(filter):
    _gcp_audit_log_entries(filter) |
    reduce .[] as $entry ({}; .[$entry.resource][$entry.outcome] |= (. + [$entry.permission] | unique));

# Returns an object with permissions as keys, with a list of "allowed" and/or
# "denied" outcomes on the listed resources.
# E.g.
# {
#   "compute.instances.create" : {
#     "allowed": [
#       "projects/PROJECT_ID/zones/ZONE/instances/INSTANCE_ID",
#       ...
#     ],
#     "denied": [
#       "projects/PROJECT_ID/zones/ZONE/instances/OTHER_INSTANCE_ID",
#       ...
#     ]
#   },
#   ...
# }
def gcp_audit_log_permissions:
    _gcp_audit_log_permissions(.permission);

# Returns an object with permissions as keys, with a list of resources for which
# the outcome of the permission was allowed.
# E.g.
# {
#   "compute.instances.create" : [
#     "projects/PROJECT_ID/zones/ZONE/instances/INSTANCE_ID",
#     ...
#   ],
#   ...
# }
def gcp_audit_log_allowed_permissions:
    _gcp_audit_log_permissions(.permission and .granted) |
    map_values(.["allowed"]);

# Returns an object with permissions as keys, with a list of resources for which
# the outcome of the permission was denied.
# E.g.
# {
#   "compute.instances.delete" : [
#     "projects/PROJECT_ID/zones/ZONE/instances/INSTANCE_ID",
#     ...
#   ],
#   ...
# }
def gcp_audit_log_denied_permissions:
    _gcp_audit_log_permissions(.permission and (.granted|not)) |
    map_values(.["denied"]);

# Returns an object with resources as keys, with a list of "allowed" and/or
# "denied" outcomes from the listed permissions.
# E.g.
# {
#   "projects/PROJECT_ID/zones/ZONE/instances/INSTANCE_ID" : {
#     "allowed": [
#       "compute.instances.create",
#       ...
#     ],
#     "denied": [
#       "compute.instances.delete",
#       ...
#     ]
#   },
#   ...
# }
def gcp_audit_log_resources:
    _gcp_audit_log_resources(.resourceAttributes.name);

# Returns an object with resources as keys, with a list of permissions for which
# the outcome when applied to the resource was allowed.
# E.g.
# {
#   "projects/PROJECT_ID/zones/ZONE/instances/INSTANCE_ID" : [
#     "compute.instances.create",
#     ...
#   ],
#   ...
# }
def gcp_audit_log_allowed_resources:
    _gcp_audit_log_resources(.resourceAttributes.name and .granted) |
    map_values(.["allowed"]);

# Returns an object with resources as keys, with a list of permissions for which
# the outcome when applied to the resource was denied.
# E.g.
# {
#   "projects/PROJECT_ID/zones/ZONE/instances/INSTANCE_ID" : [
#     "compute.instances.delete",
#     ...
#   ],
#   ...
# }
def gcp_audit_log_denied_resources:
    _gcp_audit_log_resources(.resourceAttributes.name and (.granted|not)) |
    map_values(.["denied"]);

# low-level functions; prefer the ones above
