# [Setup Odoo ]

## Scripts and It's Related Library

### Install LESS on Ubuntu with npm

```$ sudo apt-get install npm``` <br />
```$ sudo npm install -g less```

#### Check for installation: 

```$ which lessc```  <br />
```$ lessc -v```

### Install wkhtml and place on correct place for ODOO 

```$ sudo wget https://www.dropbox.com/s/if6t5vqy6fsglqs/wkhtmltox-0.12.1_linux-trusty-amd64.deb?dl=0```<br />
```$ sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb```<br />
```$ sudo cp /usr/local/bin/wkhtmltopdf /usr/bin```<br />
```$ sudo cp /usr/local/bin/wkhtmltoimage /usr/bin```


