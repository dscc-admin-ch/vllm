# vllm-deployment

## Docker deployment

Make sure you copy the vllm github repo before building the docker image

To run the container, you can use this command :

```bash
docker run --rm --env "HF_TOKEN=<your_huggingface_token>" \
  --ipc=host \
  -p 8000:8000 \
  llm-serving:vllm-cpu \
  --model facebook/opt-125m
```


## Kubernetes deployment
In order to deploy example vllm :

Go to directory `cd ./kubernetes/cpu` and use the following commands:

```bash
kubectl apply -f deployment.yaml
```

```bash
kubectl apply -f service.yaml
```

```bash
kubectl apply -f ingress.yaml
```
