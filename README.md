#### AI Machine Setup Steps

### Getting started
These instructions will get you started with the AI on a new machine
##### Tested on ubuntu 16.04 and partially on 18.04 
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
	git clone https://github.com/nikhilbv/linuxscripts.git
	alias lscripts="cd $HOME/softwares/linuxscripts"
#### - Copy softwares from samba server to local downloads manually
	scp -r nikhil@10.4.71.121:/data/samba/software/packages-for-new-system-install $HOME/Downloads
    *Note* - Move(cut & paste) all the files out of packages-for-new-system-install to $HOME/Downloads
#### - TODO: Create a init-custom.sh by looking at init.sh
	## cd $HOME/softwares/linuxscripts
	## source init-custom.sh
#### - Install graphics driver probably nvidia
	*NOTE* - Do not change/reinstall driver if it is already installed probably new system
    reboot the system once done
    sudo reboot
#### - Install cuda
	source cuda.install.sh
    add cuda repo key manually on error and again source cuda.install.sh
    cuda.repo-keys.sh // Manually
#### Optional
>#### - Install cuDNN
	source cudnn.install.sh
    ## Check gcc --version compactibility
#### - Install tensorRT
	source tensorRT.install.sh

#### - Install nvidia-cuda-toolkit
	sudo apt-get install nvidia-cuda-toolkit
#### - Install the basic utilities for system
	source init-utilities.sh
    *INFO* - Else than all the utilities, java,python, php, apache, nodejs gets installed here
#### - Setup the apache html
	*INFO* - 
    The entries are already in output in terminal
    Open and edit those two files
    
    Test the process in browser by - 
    localhost/~username
#### - Install multimedia softwares
	source init-graphics-multimedia.sh
#### - Install pre-requisite softwares
	source pre.install.sh
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
