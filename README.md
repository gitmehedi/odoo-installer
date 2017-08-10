# Setup Odoo 

## Scripts and It's Related Library

### Install LESS on Ubuntu with npm

$ sudo apt-get install npm
$ sudo npm install -g less

#### check for installation: 

$ which lessc
$ lessc -v

### Install wkhtml and place on correct place for ODOO 

sudo wget https://www.dropbox.com/s/if6t5vqy6fsglqs/wkhtmltox-0.12.1_linux-trusty-amd64.deb?dl=0
sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
sudo cp /usr/local/bin/wkhtmltopdf /usr/bin
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin


