RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
YELLOW="\[\033[33;1m\]"
WHITE="\[\033[37;1m\]"
GREEN="\[\033[01;32m\]"
SKYBLUE="\[\033[01;34m\]"
SMILEY="${WHITE}:)${NORMAL}"
FROWNY="${RED}:(${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="${debian_chroot:+($debian_chroot)}$GREEN\u@\h:\[\033[00m\]$SKYBLUE\w\[\033[00m\]\$(__git_ps1) \`${SELECT}\`\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$(__git_ps1) \$ '
fi

# ROS and singray specific
source /opt/ros/humble/setup.bash
CURRENT_ROS_WORKSPACE=ros2_ws
# CURRENT_ROS_WORKSPACE=tutorial_ws
# CURRENT_ROS_WORKSPACE=udemy_ws
source ~/${CURRENT_ROS_WORKSPACE}/install/setup.bash
# source ~/ros2_ws/install/setup.bash
# source ~/tutorial_ws/install/setup.bash
# source ~/udemy_ws/install/setup.bash
source /usr/share/colcon_cd/function/colcon_cd.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

export COLCON_LOG_PATH=~/${CURRENT_ROS_WORKSPACE}/log
COLCON_DEFAULT="{
    \"build\": {
        \"symlink-install\": true,
        \"build-base\": \"/home/gaurish/${CURRENT_ROS_WORKSPACE}/build\",
        \"install-base\": \"/home/gaurish/${CURRENT_ROS_WORKSPACE}/install\",
        \"base-paths\": [\"/home/gaurish/${CURRENT_ROS_WORKSPACE}/src\"],
        # \"build-base\": \"/home/gaurish/tutorial_ws/build\",
        # \"install-base\": \"/home/gaurish/tutorial_ws/install\",
        # \"base-paths\": [\"/home/gaurish/tutorial_ws/src\"],
        \"cmake-args\": [\"-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON\"]
    },
    # \"test\": {
    #     \"build-base\": \"/home/gaurish/ros2_ws/build\",
    #     \"install-base\": \"/home/gaurish/ros2_ws/install\",
    #     \"event-handlers\": [\"console_direct+\"],
    #     \"base-paths\": [\"/home/gaurish/ros2_ws/src\"],
    # }
}
"
echo "${COLCON_DEFAULT}" > ~/.colcon/defaults.yaml
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

alias bashrc='source ~/.bashrc; echo ~/.bashrc sourced;'
alias apt='nala'
alias buildsingray='(cd /home/gaurish/ros2_ws/; colcon build --packages-up-to singray_ros2_driver)'
export PATH=`~/.config/add_to_list.py PATH ~/.local/bin/ /snap/bin`
export LD_LIBRARY_PATH=`~/.config/add_to_list.py LD_LIBRARY_PATH ~/.local/opencv-4.2.0/lib`
export ROS_DOMAIN_ID=222
