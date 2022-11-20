USER_NAME=hosokawa
WORKSPACE=catkin_ws
sudo docker run --rm -it --privileged \
        --gpus all \
        --device=/dev/ttyUSB0:/dev/ttyUSB0 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/localtime:/etc/localtime \
        -v /home/$USER_NAME/$WORKSPACE:/home/noetic/catkin_ws \
        -e DISPLAY=$DISPLAY \
        --name glvnd \
        cuda_gui
