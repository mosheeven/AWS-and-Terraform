#! /bin/bash
sudo yum update
# sudo yum install nginx -y
sudo amazon-linux-extras install nginx1
sudo service nginx start
echo "<h1>OpsSchool Rules</h1>" | sudo tee /usr/share/nginx/html/index.html