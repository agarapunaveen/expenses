#!/bin/bash

userid=$(id -u)
echo "please enter the password"

read -s "mysql_root_password"

if [ $userid -ne 0 ]
then
	echo "u r not the root user"
else
	echo "u r the root user"
fi

VALIDATE(){
	if [ $1 -ne 0 ]
	then
		echo "$2.. is FAILURE"
	else
		echo "$2.. is SUCCESS"
	fi

}
     dnf module disable nodejs -y
     VALIDATE $? "disbaed nodejs"

     dnf module enable nodejs:20 -y
     VALIDATE $? "enabled nodejs-20"

     dnf install nodejs -y
     VALIDATE $? "installed nodejs"

     id expense
     if [ $? -ne 0 ]
     then
	     useradd expense
    	 VALIDATE $? "uaser added successfully"
     else
	     echo "expense user already created"
     fi

   mkdir -p /app
   VALIDATE $? "creating app directory"

    curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip

    VLLIDATE $? "download the code"

    cd /app
    rm -rf /app/*
    unzip /tmp/backend.zip
    VALIDATE $? "extracted backend code"

    npm install
    VALIDATE $? "installing nodejs depens"
   
    cp /home/ec2-user/expenses/backend.service   /etc/systemd/system/backend.service
    VALIDATE $? "copied backnd service"

    systemctl daemon-reload
    VALIDATE $? "DEAEMON RELOADED"
    systemctl start backend
    VALIDATE $? "START BACKEND"
    systemctl enable backend
    VALIDATE $? "ENABLE BACKEND"
    dnf install mysql -y
    VALIDATE $? "INSTALLING MYSQL"
    mysql -h 3.88.66.93  -uroot -p${mysql_root_password} < /app/schema/backend.sql
    VALIDATE $? "SETTING SCHEME"
    systemctl restart backend
    VALIDATE $? "BACKEND RESTARTED"
