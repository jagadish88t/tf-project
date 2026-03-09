#!/bin/bash
echo "🚀 Starting Minikube..."
minikube start --driver=docker

echo "📦 Installing Argo CD..."
kubectl create namespace argocd 2>/dev/null || true
kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml \
  --server-side --force-conflicts

echo "⏳ Waiting for Argo CD pods..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=180s

echo "🔧 Patching Argo CD for HTTP..."
kubectl patch deployment argocd-server -n argocd \
  --type json \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'

kubectl rollout status deployment/argocd-server -n argocd

echo "🌐 Starting port forward..."
kubectl port-forward svc/argocd-server -n argocd --address 0.0.0.0 8080:80 &

echo ""
echo "✅ Argo CD is ready!"
echo "🌐 Open port 8080 from the Ports tab"
echo ""
echo "🔑 Login credentials:"
echo "   Username: admin"
echo "   Password: $(kubectl get secret argocd-initial-admin-secret \
     -n argocd -o jsonpath="{.data.password}" | base64 -d)"
echo ""
```

Now every time you run `bash setup.sh` it prints:
```
✅ Argo CD is ready!
🌐 Open port 8080 from the Ports tab

🔑 Login credentials:
   Username: admin
   Password: xK9mP2vQnR8wLjYt