#!/bin/bash
sudo apt install awscli -y
sudo service nginx stop 
sudo bash /var/www/html/web_page.sh > /var/www/html/index.nginx-debian.html
sudo service nginx start

# add crontab
(crontab -l && echo "* 1 * * * /usr/bin/aws s3 cp /var/log/nginx/access.log s3://tf-us-east-2-state") | crontab -