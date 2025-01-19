#!/usr/bin/env bash

# X11 호환을 위해 xhost 설정 (보안 환경에 따라 조정 필요)
xhost +local:docker

# GPU 자원을 활용하기 위해 --gpus all 사용
# DISPLAY와 X11 소켓을 공유하여 GUI를 띄울 수 있도록 설정
docker run --rm -it \
    --gpus all \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $(pwd):/workspace \
    \
    # OpenNI2로 센서를 직접 연결하려면 아래와 같은 권한/device 추가가 필요할 수 있음
    # --device /dev/video0 \
    # --privileged \
    \
    --name hrbffusion3d_container \
    hrbffusion3d:latest \
    /bin/bash
