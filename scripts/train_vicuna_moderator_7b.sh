torchrun --nproc_per_node=4 --master_port=20001 fastchat/train/train_mem.py \
    --model_name_or_path /cpfs/29cd2992fe666f2a/user/mercy/model_weights/vicuna-7b-v1.5/  \
    --data_path  /cpfs/29cd2992fe666f2a/user/mercy/weilin/repos/FastChat/data/sharegpt_sub3k_moderator_data.json \
    --bf16 True \
    --output_dir vicuna_moderator_7b \
    --num_train_epochs 3 \
    --per_device_train_batch_size 2 \
    --per_device_eval_batch_size 2 \
    --gradient_accumulation_steps 16 \
    --evaluation_strategy "steps" \
    --eval_steps 1500 \
    --save_strategy "steps" \
    --save_steps 1500 \
    --save_total_limit 8 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --fsdp "full_shard auto_wrap" \
    --fsdp_transformer_layer_cls_to_wrap 'LlamaDecoderLayer' \
    --tf32 True \
    --model_max_length 2048 \
    --gradient_checkpointing True \
    --lazy_preprocess True

# --data_path /cpfs/29cd2992fe666f2a/user/mercy/weilin/repos/FastChat/data/sharegpt_sub3k_moderator_data.json \
# /cpfs/29cd2992fe666f2a/user/mercy/weilin/repos/FastChat/data/dummy_conversation.json