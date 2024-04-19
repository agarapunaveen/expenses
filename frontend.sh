#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]
then
	echo "u r not the root usere"
else
	echo "u r the root user"
fi

VALIDATE(){
if [ $1 -ne 0 ]
then
	echo "$2 .. failure"
else
	echo "$2 .. is success"
fi

}

dnf install nginx -y
VALIDATE $? "INSTALL NGINX"

systemctl enable nginx
VALIDATE $? "ENABLE NGINX"

systemctl start nginx
VALIDATE $? "START NGINS"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "REMOVE THE EXISTING CONTENT"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE $? "DOWNLOAD THE CODE"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip
VALIDATE $? "UNZIP THE CODE"

cp /home/ec2-user/expenses/expense.conf /etc/nginx/default.d/expense.conf
VALIDATE $? "COPIED SUCCESS"
systemctl restart nginx
VALIDATE $? "NGINX RESTARTED"
