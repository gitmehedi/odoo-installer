# [Odoo Installation]
- [[Odoo Installation]](#odoo-installation)
  - [Scripts and It's Related Library](#scripts-and-its-related-library)
    - [Install LESS on Ubuntu with npm](#install-less-on-ubuntu-with-npm)
      - [Sometimes it may show's error or warning, then run those command](#sometimes-it-may-shows-error-or-warning-then-run-those-command)
      - [Check for installation:](#check-for-installation)
    - [Install wkhtmltopdf and place on correct place for ODOO](#install-wkhtmltopdf-and-place-on-correct-place-for-odoo)
  - [OR Install Using](#or-install-using)
  - [Create virtual Environment](#create-virtual-environment)
    - [Virtuual Environment in 2.7](#virtuual-environment-in-27)

## Scripts and It's Related Library

### Install LESS on Ubuntu with npm

```$ sudo apt-get install -y npm``` <br />
```$ sudo npm install -g less@3.0.4```
#### Sometimes it may show's error or warning, then run those command
```$ sudo npm cache clean -f```<br />
```$ sudo npm install -g n```<br />
```$ sudo n stable```<br />

#### Check for installation: 

```$ which lessc```  <br />
```$ lessc -v```

### Install wkhtmltopdf and place on correct place for ODOO 

```$ sudo wget https://www.dropbox.com/s/if6t5vqy6fsglqs/wkhtmltox-0.12.1_linux-trusty-amd64.deb?dl=0```<br />
```$ sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb?dl=0```<br />
```$ sudo cp /usr/local/bin/wkhtmltopdf /usr/bin```<br />
```$ sudo cp /usr/local/bin/wkhtmltoimage /usr/bin```

## OR Install Using
```$ sudo apt-get -y update```<br />
```$ sudo apt-get install -y xvfb```<br />
```$ sudo apt-get install -y wkhtmltopdf```<br />

## Create virtual Environment 

### Virtuual Environment in 2.7
Install dependend os package for virtual environment  
``` $ apt-get install virtualenv```  
Configure virtual environment for python  
```$ virtualenv -p /usr/bin/python2.7 venv```
