#!/bin/bash
# Run this script to download pretrained parameters commonly used as backbones
# Usually just download some ( or one ) of them
# Current checkpoints are trained with DINO(https://arxiv.org/abs/2104.14294)
# ViT-S/16: 21M, 77.0%
# ViT-B/16: 85M, 78.2%
# ResNet-50: 23M, 75.3%
wget https://dl.fbaipublicfiles.com/dino/dino_deitsmall16_pretrain/dino_deitsmall16_pretrain.pth # ViT-S/16
wget https://dl.fbaipublicfiles.com/dino/dino_vitbase16_pretrain/dino_vitbase16_pretrain.pth # ViT-B/16
wget https://dl.fbaipublicfiles.com/dino/dino_resnet50_pretrain/dino_resnet50_pretrain.pth # ResNet-50
