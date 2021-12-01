#!/bin/bash

# This is KUBOT Robot check ARCH script.

SCRIPT_DIR_O=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
SCRIPT_NAME_O=$(basename ${BASH_SOURCE[0]})
source $SCRIPT_DIR_O/bash_utils.sh

# Check ARCH
export SYS_KERNEL=$(arch)
echo_yellow "[${SCRIPT_NAME_O}] ARCH: ${SYS_KERNEL}"

unset SCRIPT_DIR_O