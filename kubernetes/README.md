Fichier Pod.yaml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend-ctn
        image: europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/frontend-2026:projet-frontend-chaieb-farikou-diomande
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
        resources:
          requests:
            cpu: "4m"
            memory: "32Mi"