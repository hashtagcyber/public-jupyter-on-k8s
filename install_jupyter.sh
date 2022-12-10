export NAMESPACE=jupyter
export HELM_RELEASE=jupyter-experimental
export CHART_VERSION=2.0.0
# https://z2jh.jupyter.org/en/stable/jupyterhub/installation.html
#
# 1. Create config.yaml
touch config.yaml
# 2. Create the jupyter namespace
#kubectl create namespace $NAMESPACE
# 3. Install jupyterhub helm chart 
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
# 4. Deploy the helm chart 
helm upgrade --cleanup-on-fail \
  --install $HELM_RELEASE jupyterhub/jupyterhub \
  --namespace $NAMESPACE \
  --create-namespace \
  --version=$CHART_VERSION \
  --values config.yaml
# 5. Apply the tunnel  
kubectl apply -f cloudflared.yaml