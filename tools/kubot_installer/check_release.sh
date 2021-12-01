#!/bin/bash

# This is KUBOT Robot check release script.

SCRIPT_DIR_O=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
SCRIPT_NAME_O=$(basename ${BASH_SOURCE[0]})
source $SCRIPT_DIR_O/bash_utils.sh

# Check System Release Version
export SYS_VERSION=$(lsb_release -sc)
echo_yellow "[${SCRIPT_NAME_O}] Release: ${SYS_VERSION}"

unset SCRIPT_DIR_O