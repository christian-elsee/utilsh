#!/bin/sh
## Force deletes a k8s resource
## $k8s-force-delete-resource.sh pod/fubar
set -euo pipefail

## env
: ${1?req! resource}

## main
logger -sp DEBUG -- "Enter" \
	:: "resource=$1"

kubectl patch "$1" \
	-p '{"metadata":{"finalizers":[]}}' \
	--type=merge \
	--force=true
kubectl delete "$1" \
	--grace-period=0 \
	--force \
	--ignore-not-found
