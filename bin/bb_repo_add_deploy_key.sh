#!/bin/sh
#
# Add a deployment key to all repos for all team repos

# Edit/override these to correct settings
BB_TEAM=${BB_TEAM:-'teamname'}
BB_API_KEY=${BB_API_KEY:-'api_key'}
BB_PUBKEY=${BB_PUBKEY:-'./key.pub'}
BB_KEY_LABEL=${BB_KEY_LABEL:-'label'}

ROOT_URL=${ROOT_URL:-https://api.bitbucket.org/}

# Slurp contents of pub key file to var
KEY=$(while read line; do echo ${line}; done < ${BB_PUBKEY})
[ -z "${KEY}" ] && echo "Error: unable to read file ${BB_PUBKEY}" && exit 1

get()
{
    curl --silent --user ${BB_TEAM}:${BB_API_KEY} ${ROOT_URL}$*
}

post()
{
    curl --silent --user ${BB_TEAM}:${BB_API_KEY} \
	 --header 'Content-Type: application/json' \
	 --header 'Accept: application/json' \
	 --data-binary @- ${ROOT_URL}$*
}

eachRepo()
{
    local url=${1:-"2.0/repositories/${BB_TEAM}"}
    get ${url} | \
	jq '.next?,.values[].name' | sed -e 's/"//g' | \
	while read line; do
	    case "$line" in
		http*)
		    eachRepo "${line##${ROOT_URL}}"
		    ;;
		null)
		    ;;
		*)
		    echo $line
		    ;;
	    esac
	done
}

# Remove entries with existing key
filterKey()
{
    while read repo; do
	test=""
	[ -n "${repo}" ] && \
	    test=$(get 1.0/repositories/${BB_TEAM}/${repo}/deploy-keys | \
			  jq ".[]|.label==\"${BB_KEY_LABEL}\"")
	[ -z "${test}" -o "${test}" != "true" ] && echo ${repo}
    done
}

# Add deployment key to the list of repos
addKey()
{
    while read repo; do
	echo "Deploying key to ${repo}"
	echo "{\"key\": \"${KEY}\", \"label\": \"${BB_KEY_LABEL}\"}" | post 1.0/repositories/${BB_TEAM}/${repo}/deploy-keys
    done
}

eachRepo | filterKey | tr '[:upper:]' '[:lower:]' | addKey
