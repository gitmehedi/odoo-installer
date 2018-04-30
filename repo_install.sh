#!/bin/bash

repo=(
    "https://github.com/OCA/intrastat.git"
    "https://github.com/OCA/account-financial-reporting.git"
    "https://github.com/OCA/server-tools.git"
    "https://github.com/OCA/web.git"
    "https://github.com/OCA/product-attribute.git"
    "https://github.com/OCA/reporting-engine.git"
    "https://bitbucket.org/matiarrahman/odoo-community-addons.git"
    "https://github.com/OCA/operating-unit.git"
)

for element in ${repo[@]}
do
    git clone -b 8.0 --single-branch $element
    echo $element "clone complete"
done

echo "--------------------------------------"
echo "No of reporo downloads:" ${#repo[@]}

echo ""
echo ${repo[@]}
