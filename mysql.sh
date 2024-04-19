#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]
then
   echo "u r not the root user"
else
	echo "u r the root user"
fi

VALIDATE(){
	if [ $1 -ne 0 ]
	then
		echo " $2 .. is not installed"
	else
		echo " $2... is installed"
	fi
}
dnf install mysql-server -y
VALIDATE $? "mysql-server"

systemctl enable mysqld
VALIDATE $? "enable mysqld"

systemctl start mysqld
VALIDATE $? "start mysqld"

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "password setup"
