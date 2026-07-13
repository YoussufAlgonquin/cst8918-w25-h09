# CST8918 - H09: Azure Kubernetes Service (AKS) Cluster with Terraform

Terraform configuration that provisions an Azure Kubernetes Service (AKS)
cluster and deploys a sample multi-tier application (Vue frontend, two
backend services, and a RabbitMQ message broker) to it.

## Infrastructure

`main.tf` creates:

- A new resource group.
- An AKS cluster (`azurerm_kubernetes_cluster.app`) with:
  - Autoscaling default node pool, min `1` / max `3` nodes.
  - `Standard_B2s_v2` VM size (the plain `Standard_B2s` SKU is not enabled
    for this Azure for Students subscription in `canadacentral`).
  - `SystemAssigned` managed identity.
  - The latest available Kubernetes version for the target region
    (looked up via the `azurerm_kubernetes_service_versions` data source).

`outputs.tf` exposes the cluster's `kube_config` (marked `sensitive`) so it
can be used to connect with `kubectl`.

## Usage

### 1. Provision the cluster

```sh
terraform init
terraform plan
terraform apply
```

### 2. Connect with kubectl

```sh
echo "$(terraform output kube_config)" > ./kubeconfig
```

Check the file — if it starts with `<<<eof` and ends with `eof`, edit the
file to remove those two lines. Then:

```sh
export KUBECONFIG=./kubeconfig
kubectl get nodes
```

### 3. Deploy the sample application

```sh
kubectl apply -f sample-app.yaml
```

Verify:

```sh
kubectl get pods
kubectl get services
```

Use the external IP address of the `store-front` service to access the
application in a browser.

## Clean up

```sh
kubectl delete -f sample-app.yaml
terraform destroy
```
