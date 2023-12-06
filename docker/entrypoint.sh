#!/bin/bash

# Check if the MODEL_NAME environment variable is set and not empty
if [ -z "$MODEL_NAME" ]; then
    echo "Environment variable MODEL_NAME is not set. Exiting."
    exit 1
fi

# Check the first argument
if [ "$1" = "vllm" ]; then
    WORKER_MODULE="fastchat.serve.vllm_worker"
else
    WORKER_MODULE="fastchat.serve.model_worker"
fi

# Start the worker in the background with nohup
nohup python3 -m $WORKER_MODULE \
  --model-path /mnt/models/$MODEL_NAME \
  --port 8082 \
  --host 0.0.0.0 \
  --num-gpus $(nvidia-smi --list-gpus | wc -l) \
  --worker-address http://localhost:8082 &

# Get the PID of the background process
PID=$!

# Timeout for the loop in seconds
TIMEOUT=600
START_TIME=$(date +%s)

# Loop to check the log file
while true; do
    # Check if the process is still running
    if ! ps -p $PID > /dev/null; then
        echo "The worker process has exited unexpectedly."
        exit 1
    fi

    # Check if "startup complete" is in the log file
    if grep -q "startup complete" worker_output.log; then
        echo "Startup complete, executing the openai_api_server..."
        python3 -m fastchat.serve.openai_api_server --host 0.0.0.0 --port 8080
        break
    fi

    # Check for timeout
    CURRENT_TIME=$(date +%s)
    if [ $((CURRENT_TIME - START_TIME)) -gt $TIMEOUT ]; then
        echo "Timeout reached. Exiting."
        exit 1
    fi

    # Wait for a short time before checking again
    sleep 10
done