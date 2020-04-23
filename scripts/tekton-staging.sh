#!/bin/bash env

# Install Tekton Pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Install Tekton Triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml


# Ingress NGINX Mandatory file

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml

# Ingress NGINX GKE
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/cloud-generic.yaml

sleep 30

#Install service accounts
kubectl apply -f ../tekton/gitlab/role-resources/triggerbinding-roles
kubectl apply -f ../tekton/gitlab/role-resources/secret.yaml
kubectl apply -f ../tekton/gitlab/role-resources/serviceaccount.yaml

## Install Event Listener
kubectl apply -f ../tekton/gitlab/gitlab-push-listener.yaml


# Install GitLab Ingress
kubectl apply -f ../tekton/gitlab/gitlab-ingress.yaml