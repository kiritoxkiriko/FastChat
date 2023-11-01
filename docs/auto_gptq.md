# GPTQ Inference by AutoGPTQ

Support GPTQ Inference by [AutoGPTQ](https://github.com/PanQiWei/AutoGPTQ).

See more details in [AutoGPTQ](https://github.com/PanQiWei/AutoGPTQ)

## Install

Setup environment:
```bash
#For CUDA 11.7: 
pip install auto-gptq
#For CUDA 11.8: 
pip install auto-gptq --extra-index-url https://huggingface.github.io/autogptq-index/whl/cu118/
#For RoCm 5.4.2: 
pip install auto-gptq --extra-index-url https://huggingface.github.io/autogptq-index/whl/rocm542/
```

Chat with the CLI:
```bash
python3 -m fastchat.serve.cli \
    --model-path facebook/opt-125m \
    --auto-gptq True \
    --gptq-wbits 4 \
    --gptq-groupsize 128
```

Start model worker:
```bash
python3 -m fastchat.serve.model_worker \
    --model-path models/vicuna-7B-1.1-GPTQ-4bit-128g \
    --auto-gptq True \
    --gptq-wbits 4 \
    --gptq-groupsize 128

# You can specify which quantized model to use
python3 -m fastchat.serve.model_worker \
    --model-path models/vicuna-7B-1.1-GPTQ-4bit-128g \
    --gptq-ckpt models/vicuna-7B-1.1-GPTQ-4bit-128g/vicuna-7B-1.1-GPTQ-4bit-128g.safetensors \
    --auto-gptq True \
    --gptq-wbits 4 \
    --gptq-groupsize 128 \
    --gptq-act-order
```

## Supported Models
See [AutoGPTQ-supported-models](https://github.com/PanQiWei/AutoGPTQ#supported-models)
