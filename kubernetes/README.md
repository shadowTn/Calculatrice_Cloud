# Kubernetes - Déploiement de l'application

Tous les manifests K8s sont ici.

## Contenu
- `pod.yaml` :  ReplicaSet frontend
- `backend.yaml` : Deployment backend (API)
- `consumer.yaml` : Deployment consumer
- `redis.yaml` : Deployment Redis
- `rabbit.yaml` : Deployment RabbitMQ
- `ingress.yaml` : Ingress avec nginx

## Commandes
kubectl apply -f pod.yaml
kubectl apply -f backend.yaml
kubectl apply -f consumer.yaml
kubectl apply -f redis.yaml
kubectl apply -f rabbit.yaml
kubectl apply -f ingress.yaml

## Vérification
kubectl get pods -n chaieb-farikou-diomande
kubectl get svc -n chaieb-farikou-diomande
kubectl get ingress -n chaieb-farikou-diomande


## Lancement des Pods sur localhost

kubectl port-forward frontend-rs-zrjc2 8080:80 --address 0.0.0.0
kubectl port-forward backend-99cc78bcc-rdjrm  8000:8000 --address 0.0.0.0
kubectl port-forward rabbitmq-bf68cb95b-lbwqq 15672:15672 --address 0.0.0.0
kubectl port-forward redis-7f48fc7f5f-58f5j 6379:6379 --address 0.0.0.0






## Test sur localhost

curl -X POST http://localhost:8000/api/operation   -H "Content-Type: application/json"   -d '{"fir
st_element":"5", "second_element":"3", "operation":"*"}'

curl http://localhost:8000/api/result/+{id}

