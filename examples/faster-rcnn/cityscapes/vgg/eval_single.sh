#!/bin/bash
ROOT=../../../..
export PYTHONPATH=$ROOT:$PYTHONPATH
#--------------------------
job_name=Test
ckdir=4cluster
mkdir -p ./${ckdir}/${job_name}
#--------------------------

python -u $ROOT/tools/faster_rcnn_train_val.py \
  --config=config_512.json \
  --dist=0 \
  --fix_num=3 \
  --L1=1 \
  -e \
  --cluster_num=4 \
  --threshold=128 \
  --recon_size=256 \
  --port=21603 \
  --arch=vgg16_FasterRCNN \
  --warmup_epochs=1 \
  --lr=0.0000125 \
  --step_epochs=16,22 \
  --batch-size=1 \
  --epochs=25 \
  --dataset=cityscapes \
  --resume=/path/to/checkpoint.pth \
  --train_meta_file=/path/to/train.txt \
  --target_meta_file=/path/to/foggy_train.txt \
  --val_meta_file=/path/to/foggy_val.txt \
  --datadir=/path/to/leftImg8bit/ \
  --pretrained=/path/to/torchvision_models/vgg16-397923af.pth \
  --results_dir=${ckdir}/${job_name}/results_dir \
  --save_dir=${ckdir}/${job_name} \
  2>&1 | tee ${ckdir}/${job_name}/train.log
