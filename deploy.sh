docker build -t akovalenko/multi-client:latest -t akovalenko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akovalenko/multi-server:latest -t akovalenko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akovalenko/multi-worker:latest -t akovalenko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akovalenko/multi-client:latest
docker push akovalenko/multi-server:latest
docker push akovalenko/multi-worker:latest

docker push akovalenko/multi-client:$SHA
docker push akovalenko/multi-server:$SHA
docker push akovalenko/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akovalenko/mulpti-server:$SHA
kubectl set image deployments/client-deployment client=akovalenko/mulpti-client:$SHA
kubectl set image deployments/worker-deployment worker=akovalenko/mulpti-worker:$SHA