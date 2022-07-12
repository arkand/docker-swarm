#!/bin/bash
set -eu

# Login to ECR

GET_LOGIN_OUTPUT="$(aws ecr get-login-password)"
LOGIN_ARGS="$(echo "$GET_LOGIN_OUTPUT" | sed 's/^docker login \(.*\)/\1/g')"
aws ecr get-login-password --region ap-southeast-3 | docker login --username AWS --password-stdin 037124765686.dkr.ecr.ap-southeast-3.amazonaws.com
if [ -n "$LOGIN_ARGS" ]; then
    #docker login ${LOGIN_ARGS[@]}
    if [ $? -eq 0 ]; then
        >&2 echo "Docker login succeeded"

        # Refresh auth tokens
        >&2 echo "Running docker update swarm services registry auth"
        SERVICES=$(docker service ls --format '{{.ID}}' 2>/dev/null)
        for SERVICE in $SERVICES; do
	    echo $SERVICE
            docker service update -d -q --with-registry-auth $SERVICE
        done
    else
        >&2 echo "Docker login failed"
        exit 1
    fi
else
    >&2 echo "Failed to acquire docker login credentials"
    exit 1
fi
