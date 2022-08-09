docker build -t hatang/multi-client:latest -t hatang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hatang/multi-server:latest -t hatang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hatang/multi-worker:latest -t hatang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hatang/multi-client:latest
docker push hatang/multi-server:latest
docker push hatang/multi-worker:latest

docker push hatang/multi-client:$SHA
docker push hatang/multi-server:$SHA
docker push hatang/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=hatang/multi-server:$SHA
kubectl set image deployments/client-deployment client=hatang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hatang/multi-worker:$SHA