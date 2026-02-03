# Les commandes nécéssaires pour contruire les images de conteneur du projet

docker build -t projet-frontend:latest .
docker build -t projet-backend:latest .
docker build -t projet-consumer:latest .

# Les commandes nécéssaires pour pousser les images dans Google Artifact Registry

- gcloud auth activate-service-account student@polytech-dijon.iam.gserviceaccount.com --key-file="../student.json"
- gcloud config set project polytech-dijon
- gcloud auth configure-docker europe-west1-docker.pkg.dev

- docker tag projet-frontend:latest europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/frontend:projet-frontend-chaieb-farikou-diomande
- docker tag projet-backend:latest europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/projet-backend:moussa-amen
- docker tag projet-consumer:latest europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/projet-consumer:moussa-amen


- docker push europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/frontend:projet-frontend-chaieb-farikou-diomande
- docker push europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/projet-backend:moussa-amen
- docker push europe-west1-docker.pkg.dev/polytech-dijon/polytech-dijon/projet-consumer:moussa-amen
