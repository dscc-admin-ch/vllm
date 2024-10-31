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

### Local Model

If you want to load the model locally (instead of downloading the model on huggingface when running the container), you can do it following these steps:

1. First copy the model locally from the huggingface repository
```bash
git lfs install
```

```bash
git clone https://huggingface.co/facebook/model_name
```

2. Then run this command

```bash
docker run --rm --env "HF_TOKEN=<your_huggingface_token>" --ipc=host -p 8000:8000 -v path/to/local/clone/model:/root/.cache/huggingface lancelotmarti/llm-serving python vllm/entrypoints/openai/api_server.py --model /root/.cache/huggingface/model_name
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


## Helm deployment
In order to deploy using helm :

Go to directory `cd ./helm/charts/vllm-gpu` and use the following command:

```bash
helm install llm-serving .
```


### From published chart
In order to install the published helm chart

```bash
helm repo add vllm https://dscc-admin-ch.github.io/helm-charts
```

Then, load and adapt the default values.yaml
```bash
helm show values vllm/llm-serving > values.yaml
```

And finally, install it:
```bash
helm install llm-serving -f values.yaml vllm/llm-serving 
```