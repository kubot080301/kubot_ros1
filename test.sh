#!/bin/bash
# Initialize KUBOT Robots setting and establish the environment required by kubot_ros1.
# For more explanation, please read here:
# https://

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
SCRIPT_NAME=$(basename ${BASH_SOURCE[0]})
source $SCRIPT_DIR/tools/kubot_installer/bash_utils.sh

# sudo ln -sf ~/kubot_ros1/kubot_init_env.sh /usr/bin/kubot_init_env
# sudo ln -sf ~/kubot_ros1/tools/kubot_view_env.sh /usr/bin/kubot_view_env

# Check System Version

source $SCRIPT_DIR/tools/kubot_installer/check_release.sh
source $SCRIPT_DIR/tools/kubot_installer/check_arch.sh
