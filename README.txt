HOW TO MAKE DUCKLINGTON AND BUCKNELL:


#THIS APPLIES VICE VERSA for Ducklington and Bucknell

in ec2 instance > sudo -i > wget https://raw.githubusercontent.com/mgarcia554/mgarcia554/master/PullDown.sh 

next enter > sh ./PullDown.sh > now enter > nano PullDown.sh > notice wget links > type them up in terminal > tar -xzvf DuckFi.tar.gz > nano httpd.conf > where it says *:80 > replace * with the private IP of the ec2 instance

now enter > sh ./ducklingtonInst.sh > run this script twice for integrity purposes > now web into the ec2 instance using the public ip in a web browser > notice how it works
