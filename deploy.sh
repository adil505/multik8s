docker build -t astelware/multi-docker-client:latest -t astelware/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t astelware/multi-docker-server:latest -t astelware/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t astelware/multi-docker-worker:latest -t astelware/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker
docker push astelware/multi-docker-client:latest
docker push astelware/multi-docker-server:latest
docker push astelware/multi-docker-worker:latest
docker push astelware/multi-docker-client:$SHA
docker push astelware/multi-docker-server:$SHA
docker push astelware/multi-docker-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=astelware/multi-docker-client:$SHA
kubectl set image deployments/server-deployment server=astelware/multi-docker-server:$SHA
kubectl set image deployments/worker-deployment worker=astelware/multi-docker-worker:$SHA
