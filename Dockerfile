FROM runpod/worker-comfyui:5.5.1-base

# Install comfy-env (required for PozzettiAndrea nodes)
RUN pip install comfy-env

# Install ComfyUI-TRELLIS2 custom node
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/PozzettiAndrea/ComfyUI-TRELLIS2.git && \
    cd ComfyUI-TRELLIS2 && \
    pip install -r requirements.txt && \
    python install.py

# Install ComfyUI-GeometryPack (includes Blender auto-download via install.py)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/PozzettiAndrea/ComfyUI-GeometryPack.git && \
    cd ComfyUI-GeometryPack && \
    pip install -r requirements.txt && \
    python install.py

# Download TRELLIS.2-4B model (~16GB)
RUN mkdir -p /comfyui/models/trellis2/ckpts && \
    cd /comfyui/models/trellis2/ckpts && \
    wget -q --no-check-certificate -O shape_enc_next_dc_f16c32_fp16.safetensors \
        https://huggingface.co/microsoft/TRELLIS.2-4B/resolve/main/ckpts/shape_enc_next_dc_f16c32_fp16.safetensors && \
    wget -q --no-check-certificate -O shape_enc_next_dc_f16c32_fp16.json \
        https://huggingface.co/microsoft/TRELLIS.2-4B/resolve/main/ckpts/shape_enc_next_dc_f16c32_fp16.json

# Download TRELLIS-image-large model (~320MB)
RUN mkdir -p /comfyui/models/trellis2/ckpts && \
    cd /comfyui/models/trellis2/ckpts && \
    wget -q --no-check-certificate -O ss_dec_conv3d_16l8_fp16.safetensors \
        https://huggingface.co/microsoft/TRELLIS-image-large/resolve/main/ckpts/ss_dec_conv3d_16l8_fp16.safetensors && \
    wget -q --no-check-certificate -O ss_dec_conv3d_16l8_fp16.json \
        https://huggingface.co/microsoft/TRELLIS-image-large/resolve/main/ckpts/ss_dec_conv3d_16l8_fp16.json && \
    wget -q --no-check-certificate -O slat_dec_gs_swin8_B_64l8gs32_fp16.safetensors \
        https://huggingface.co/microsoft/TRELLIS-image-large/resolve/main/ckpts/slat_dec_gs_swin8_B_64l8gs32_fp16.safetensors && \
    wget -q --no-check-certificate -O slat_dec_gs_swin8_B_64l8gs32_fp16.json \
        https://huggingface.co/microsoft/TRELLIS-image-large/resolve/main/ckpts/slat_dec_gs_swin8_B_64l8gs32_fp16.json

# Download DINOv3 model (~1GB, required for image encoding)
RUN mkdir -p /comfyui/models/facebook/dinov3-vitl16-pretrain-lvd1689m && \
    cd /comfyui/models/facebook/dinov3-vitl16-pretrain-lvd1689m && \
    wget -q --no-check-certificate -O model.safetensors \
        https://huggingface.co/facebook/dinov3-vitl16-pretrain-lvd1689m/resolve/main/model.safetensors

# Copy workflow file
COPY comfy_workflow.json /comfyui/
