# Habilitar dns e ingress addons
sudo microk8s enable dns ingress

# Instalar ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml

# Generar certificado TLS
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout app1.key -out app1.crt -subj \
"/CN=app1.example.com/O=app1"

# Crear secret para el certificado TLS
kubectl create secret tls app1-tls --cert=app1.crt --key=app1.key
kubectl create secret tls app2-tls --cert=app2.crt --key=app2.key

# Desplegar la aplicacion
sudo microk8s kubectl apply -f app1.yml

# Crear el ingress para la aplicacion
sudo microk8s kubectl apply -f ingress.yml