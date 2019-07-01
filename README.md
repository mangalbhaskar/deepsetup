# AI Machine Setup Steps

A curated list of Shell Scripts, Resources, Libraries, Software for AI ML DL . Inspired by [`linuxscripts`](https://github.com/mangalbhaskar/linuxscripts)


Tested on `Ubuntu 16.04 LTS` and `Ubuntu  18.04 LTS`


## Remote Access Setup (optional)
* Terminal commands for remote access
  ```bash
  sudo apt-get install openssh-server openssh-client dconf-editor
  ```
* Allow ubuntu to do automatic login from `system settings panel`
* `gsettings` for remote access:
  ```bash
  sudo gsettings set org.gnome.Vino require-encryption false
  ```
* Remote desktop sharing preferences
  ```bash
  sudo vino-preferences
  ```
* Check `Allow other users to view desktop`
* Uncheck `You must confirm each access to this machine`
* Check `Require the user to enter this password: <password>`


## System Setup

### 1. Pre-requisites
```bash
## 1. Install `git`
sudo apt update
sudo apt install git
#
## 2. Clone linuxscripts
#
mkdir -p ${HOME}/softwares
git clone https://github.com/nikhilbv/deepsetup.git ${HOME}/softwares/deepsetup
alias dsetup="cd ${HOME}/softwares/deepsetup"
#
##3. Copy softwares from `samba5/softwares/packages-for-new-system-install` to local system under `$HOME/Downloads` manually, or use `rsync`
#
smbuser="nikhil"
smbserver="10.4.71.121"
remotepath="/data/samba/software/packages-for-new-system-install"
rsync -r ${smbuser}@${smbserver}:${remotepath} $HOME/Downloads
```
### 2. Nvidia driver installation
* **WARNING:**
  * Do not change/reinstall driver if it is already installed probably in new system
  * Check using command 'nvidia-smi'
  * Reboot happens once the nvidia graphics driver is installed
```bash
cd $HOME/softwares/deepsetup
source init-nvidia.sh
```
  * To check the drivers
  ```bash
  cd $HOME/softwares/deepsetup
  source nvidia-driver-info.sh
  ```
  
### 3. Install cuda
* **WARNING:**
  * Add cuda repo key manually on error and again "source cuda.install.sh"
    * Keys for Nvidia CUDA signed repo
    ```bash
    gpg --keyserver keyserver.ubuntu.com --recv-keys F60F4B3D7FA2AF80
    gpg --export --armor F60F4B3D7FA2AF80 | sudo apt-key add -
    ```
    ```bash
    source cuda.install.sh
    ```

### 4. Run setup script
* **Execute `setup.sh` which is a binding of all softwares**
```bash
source setup.sh
```
    * **WARNING:**
       * Setup apache configuration for userdir, wsgi
       * The entries are already in output in terminal
       * Open and edit those two files

* **Optional Packages**
  * Install cuDNN
    ```bash
    ## Check gcc --version compactibility
    gcc --version
    source cudnn.install.sh
    ```
  * Install tensorRT
    ```bash
    source tensorRT.install.sh
  ```
* **Apache server test**
  * Test the apache2, process in browser by:
  ```bash
  http://localhost/~<username>
  http://localhost/~<username>/info.php
  ```
* **Python environment setup**
  * Now install the python environment wrappers for both python2 and python3
  ```bash
  #
  ## For python2
  source python.virtualenvwrapper.install.sh 2
  #
  ## For python3
  source python.virtualenvwrapper.install.sh 3
  #
  ## `deactivate` is the command used to exit from environment
	deactivate
  ```
  * Install the required packages for AI only in python3 env:
    ```bash
    workon py_3 <and press tab key>
    pip install -r python.requirements-extras.txt
    pip install -r python.requirements-ai.txt
    ```
  * **Note**: If there is an interrupt and the installation fails, restart the installation


### 5. **Setup AI Directories**

* Clone the ai-ml-dl directory
  ```bash
  cd $HOME/Documents
  git clone swuser@10.4.71.100:/home/mapdata/software/git-repo/ai-ml-dl
  ```
* Clone MRCNN from github in external folder of aimldl
  ```bash
  cd $HOME/Documents/ai-ml-dl/external
	git clone https://github.com/mangalbhaskar/Mask_RCNN.git
  ```
* Copy the model data from AI server to local system
  ```bash
  ##  copy vidteq folder from _/home/alpha/ai-ml-dl-data/data/vidteq to same data structure
  source copydata.sh
  ```
* Setup the local AI paths and dnn configurations
  ```bash
  cd $HOME/Documents/ai-ml-dl
  source setup.sh
  ```
* Manual checks and changes to be done
  1. Change the ip in `index.py` i.e., `$AI_HOME/www/public_html/od/wsgi-bin/index.py`: `app.run(debug=True, host='10.4.71.59')`
  2. Create directory `pixel` in `$AI_HOME/www/uploads`: `mkdir -p $AI_HOME/www/uploads/pixel`
