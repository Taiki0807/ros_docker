# GPUとGUIが使えるDockerfileをamd64で動かす
FROM nvidia/cudagl:11.0.3-devel-ubuntu20.04

ENV USERNAME developer
# add new sudo user
ENV HOME /home/$USERNAME
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

# これを入れないとtzdataで設定入力を求められて停止する
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata


ENV ROS_DISTRO foxy
# ロケールのセットアップ
RUN apt-get update && apt-get install -y locales && \
    dpkg-reconfigure locales && \
    locale-gen ja_JP ja_JP.UTF-8 && \
    update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
ENV LC_ALL   ja_JP.UTF-8
ENV LANG     ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
# APTソースリストの設定
RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release && \
    curl http://repo.ros2.org/repos.key | apt-key add - && \
    sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu \
    `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
# Install ROS2 packages and setting
RUN export ROS_DISTRO=foxy && \
	apt-get update && \
    apt-get install -y ros-$ROS_DISTRO-desktop \
    python3-colcon-common-extensions python3-rosdep python3-argcomplete && \
    sudo apt install -y --no-install-recommends ros-foxy-gazebo-ros-pkgs

USER $USERNAME
WORKDIR /home/$USERNAME

SHELL ["/bin/bash", "-c"]
## 環境設定
RUN    echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN    echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN    echo "export _colcon_cd_root=~/ros2_ws" >> ~/.bashrc
