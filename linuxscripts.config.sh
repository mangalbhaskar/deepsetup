#!/bin/bash

##----------------------------------------------------------
### config - path and other configurations
## Tested on Ubuntu 16.04 LTS, Ubuntu 18.04 LTS
##----------------------------------------------------------

## TODO: New mechanism, to be tested thoroughly
LINUX_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

BASEDIR="softwares"
# BASEDIR="Documents"

# BASEPATH="$HOME/softwares"

BASEPATH="$HOME/$BASEDIR"
# DOWNLOADS="$HOME/Downloads"

LINUX_SCRIPT_BASE="softwares/linuxscripts"
#echo $LINUX_SCRIPT_BASE
# LINUX_SCRIPT_HOME=$HOME/$LINUX_SCRIPT_BASE
LINUX_SCRIPT_HOME="${LINUX_SCRIPTS_DIR}"
#echo $LINUX_SCRIPT_HOME

BASHRC_FILE="$HOME/.bashrc"
#BASHRC_FILE="$LINUX_SCRIPT_HOME/.bashrc-custom"
#echo $BASHRC_FILE

## Virtual Machines, Containers, Python virtual environments
VM_BASE="virtualmachines"
VM_HOME="$HOME/$VM_BASE"
PY_VENV_PATH="$VM_HOME/virtualenvs"

LINUX_VERSION="$(lsb_release -sr)"
LINUX_CODE_NAME=$(lsb_release -sc)
LINUX_ID=$(lsb_release -si) ## Ubuntu, Kali

source $LINUX_SCRIPT_HOME/versions.sh
source $LINUX_SCRIPT_HOME/numthreads.sh
source $LINUX_SCRIPT_HOME/common.sh
