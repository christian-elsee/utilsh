#!/bin/sh
## Force deletes a namespace - provided by chatgpt
set -euo pipefail

## env
: ${1?req! namespace}

## main
logger -sp DEBUG -- "Enter" \
	:: "namespace=$1"

kubectl get namespace "$1" -o json \
	| jq 'del(.spec.finalizers)' \
	| kubectl replace \
			--raw "/api/v1/namespaces/$1/finalize" \
			-f-
kubectl delete namespace "$1" ||:
