# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Note: All custom nodes are listed under unknown_registry and none include an aux_id (GitHub repo) or a registry id,
# so they cannot be automatically installed. Each entry below is left as a comment explaining it could not be resolved.
# Could not resolve unknown_registry node Trellis2LoadImageWithTransparency - no aux_id provided
# Could not resolve unknown_registry node Preview3D - no aux_id provided
# Could not resolve unknown_registry node Trellis2ExportMesh - no aux_id provided
# Could not resolve unknown_registry node Trellis2LoadModel - no aux_id provided
# Could not resolve unknown_registry node Trellis2MeshWithVoxelGenerator - no aux_id provided
# Could not resolve unknown_registry node Trellis2PostProcessAndUnWrapAndRasterizer - no aux_id provided
# Could not resolve unknown_registry node Trellis2PreProcessImage - no aux_id provided

# download models into comfyui
# No models were specified in the workflow

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
