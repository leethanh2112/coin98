# Build Docker Image
```
docker build -t api-exam . 
```

# Push image to registry
```
docker login registry.coin98.com -u username-xxx -p password-xxx
docker tag api-exam:latest registry.coin.com/api-exam:latest
docker push registry.coin.com/api-exam:latest
```

# Update AWS Credentials
## Update values.yml in chart directory
```
env:
  AWS_ACCESS_KEY_ID:
    value: "x.x.x.x"
  AWS_SECRET_ACCESS_KEY:
    value: "x.x.x.x"
  AWS_DEFAULT_REGION:
    value: "x.x.x.x"
```

# Deploy Kubernetes
## Assuming the ingress-nginx and metallb had been installed in kubernetes cluster
```
helm registry login registry.coin.com --username username-xxx --password password-xxx
helm package chart --version v1.0
helm push api-exam-v1.0.tgz oci://registry.coin98.com/api-exam
helm upgrade --install api-exam oci://registry.coin98.com/api-exam --version v1.0 --namespace exam --values chart/values.yml
```
# Checking Kubernetes objects
```
kubectl get pod -n exam
kubectl get svc -n exam
kubectl get ingress -n exam
```
# How to use api
Mapping domain exam.coin98.com to IP loadbalance on ingress-nginx. Excuting curl command
```
curl -X POST -F "file=@/root/coin98/upload_file.txt" https://exam.coin98.com
```

# CICD
```
Refer at ".gitlab-ci.yml" file
```




