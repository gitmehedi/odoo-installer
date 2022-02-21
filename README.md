# [Odoo Installation]

- [[Odoo Installation]](#odoo-installation)
    - [Install Node and Less](#install-node-and-less)
      - [Install npm and lessc in debian based os](#install-npm-and-lessc-in-debian-based-os)
      - [If fresh install isn't work properly then follow those instruction in below](#if-fresh-install-isnt-work-properly-then-follow-those-instruction-in-below)
      - [Check lessc version on installed environment](#check-lessc-version-on-installed-environment)
    - [Install WKHTMLTOPDF](#install-wkhtmltopdf)
      - [Install from Linux repository](#install-from-linux-repository)
      - [Install from on-premise software repository](#install-from-on-premise-software-repository)
    - [Create virtual Environment](#create-virtual-environment)
      - [Virtuual Environment in 2.7](#virtuual-environment-in-27)
      - [Virtuual Environment in 2.7](#virtuual-environment-in-27-1)

### Install Node and Less
#### Install npm and lessc in debian based os

```
$ sudo apt-get install -y npm 
$ sudo npm install -g less@3.0.4
```

#### If fresh install isn't work properly then follow those instruction in below
```
$ sudo npm cache clean -f
$ sudo npm install -g n
$ sudo n stable
```

#### Check lessc version on installed environment

```
$ which lessc
$ lessc -v
```

### Install WKHTMLTOPDF

#### Install from Linux repository
```
$ sudo apt-get -y update
$ sudo apt-get install -y xvfb
$ sudo apt-get install -y wkhtmltopdf
```
#### Install from on-premise software repository

```
$ sudo wget https://www.dropbox.com/s/if6t5vqy6fsglqs/wkhtmltox-0.12.1_linux-trusty-amd64.deb?dl=0
$ sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb?dl=0
$ sudo cp /usr/local/bin/wkhtmltopdf /usr/bin
$ sudo cp /usr/local/bin/wkhtmltoimage /usr/bin
```
#### Version Check of WKHTMLTOPDF
```
$ wkhtmltopdf --version
$ $ wkhtmltoimage --version
```
### References:
- https://computingforgeeks.com/install-wkhtmltopdf-on-ubuntu-debian-linux/
- https://wkhtmltopdf.org/downloads.html

### Create virtual Environment 

#### Virtuual Environment for python2
Install dependend os package for virtual environment  
``` 
$ apt-get install -y virtualenv
```  
Configure virtual environment for python  
```
$ virtualenv -p /usr/bin/python2.7 venv
```


#### Virtuual Environment for python3
Install dependend os package for virtual environment  
``` 
$ apt-get install -y venv
```  
Configure virtual environment for python  
```
$ python3 -m venv venv
```
