docker build -t rahulvdalal/multi-client:latest -t rahulvdalal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rahulvdalal/multi-server:latest -t rahulvdalal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rahulvdalal/multi-worker:latest -t rahulvdalal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rahulvdalal/multi-client:latest -t rahulvdalal/multi-client:$SHA
docker push rahulvdalal/multi-server:latest -t rahulvdalal/multi-server:$SHA
docker push rahulvdalal/multi-worker:latest -t rahulvdalal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=rahulvdalal/multi-client:$SHA
kubectl set image deployments/server-deployment server=rahulvdalal/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rahulvdalal/multi-worker:$SHA