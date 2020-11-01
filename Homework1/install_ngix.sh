#! /bin/bash
sudo apt update
sudo apt install nginx -y
# sudo amazon-linux-extras install nginx1
sudo service nginx start
echo "<h1>OpsSchool Rules</h1>" | sudo tee /var/www/html/index.nginx-debian.html