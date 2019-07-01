#### AI Machine Setup Steps

### Getting started
These instructions will get you started with the AI on a new machine
##### Tested on 16.04 and 18.04
### Optional
> #### *NOTE* - Terminal Commands for remote access below:
    - sudo apt-get install openssh-server openssh-client dconf-editor
    - allow ubuntu to do automatic login from `system settings panel`
    - gsettings for remote access
    sudo gsettings set org.gnome.Vino require-encryption false
    - remote desktop sharing preferences
    sudo vino-preferences
    - check `Allow other users to view desktop`
    - uncheck `You must confirm each access to this machine`
    - check `Require the user to enter this password: <password>`

### Requisites
#### - Git
	sudo apt-get update
	sudo apt-get install git
#### - Linuxscripts
    cd $Home
    mkdir softwares | cd softwares
    git clone https://github.com/nikhilbv/deepsetup.git
    alias dsetup="cd $HOME/softwares/deepsetup"
#### - Copy softwares from samba server to local downloads manually
    rsync -r nikhil@10.4.71.121:/data/samba/software/packages-for-new-system-install $HOME/Downloads
    *Note* - Move(cut & paste) all the files out of packages-for-new-system-install to $HOME/Downloads
#### - Source setup.sh which is a binding of all softwares
     cd $HOME/softwares/deepsetup
     source setup.sh
     
     *NOTE* - 1. Do not change/reinstall driver if it is already installed probably new system
     		 2. Reboot happens once the nvidia graphics driver is installed
     		 3. Add cuda repo key manually on error and again "source cuda.install.sh"
     		    * Keys for Nvidia CUDA signed repo
				   gpg --keyserver keyserver.ubuntu.com --recv-keys F60F4B3D7FA2AF80
				   gpg --export --armor F60F4B3D7FA2AF80 | sudo apt-key add -
              4. Setup apache html
                 * The entries are already in output in terminal
                 * Open and edit those two files
              5. Python 3 by default is passed as arguement for wrapper
#### Optional
>#### - Install cuDNN
  source cudnn.install.sh
    ## Check gcc --version compactibility
#### - Install tensorRT
  source tensorRT.install.sh

#### - Test the apache html
    Test the process in browser by - 
    localhost/~username

#### - Now install the python environment wrappers for both python2 and python3
#### Optional
>##### - For python2
  source python.virtualenvwrapper.install.sh 2

##### - For python3
  source python.virtualenvwrapper.install.sh 3

    *Note* - 'deactivate' is the command used to exit from environment
	deactivate
#### - Install the required packages for AI only in python3 env i.e.,
    workon py_3 and press tab key
    pip install -r python.requirements-extras.txt
    pip install -r python.requirements-ai.txt

    *Note* - If there is an interrupt and the installation fails, restart the installation
### Set up AI directory structure
##### - Clone the ai-ml-dl directory
    cd $HOME/Documents
	git clone swuser@10.4.71.100:/home/mapdata/software/git-repo/ai-ml-dl
##### - Clone MRCNN from github in external folder of aimldl
    cd $HOME/Documents/ai-ml-dl/external
	git clone https://github.com/mangalbhaskar/Mask_RCNN.git
#### - Copy the vidteq folder from _/home/alpha/ai-ml-dl-data/data/vidteq_ to same data structure
	source copydata.sh
##### - Set up the local AI paths and other required stuff
	cd $HOME/Documents/ai-ml-dl
	source setup.sh
#### - Cheaks/Changes to be done
    1. Change the ip in index.py i.e., $AI_HOME/www/public_html/od/wsgi-bin/index.py
    ## app.run(debug=True, host='10.4.71.59')
    2. Create directory 'pixel' in $AI_HOME/www/uploads
