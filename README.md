# docker-zoneminder
Zoneminder ,v1.32.3. docker image with MSMTP
Usage :

sudo docker create -t -p 8085:80 --shm-size=4096m -e TZ=Asia/Colombo --name myzm --privileged=true bkjaya1952/docker-zoneminder:v1.32.3.

Note :- use your timezone instead of "TZ=Asia/Colombo"

sudo docker start myzm

Configuring MSMTP for emailing zoneminder motion detection events

Make the following file in the home folder of your computer and copy in to the zm container that you have created by above mentioned commands

Open the Ubuntu terminal and run

sudo gedit msmtprc

Then copy the following scripts with modifications to suit your gmail address and save

defaults

auth on

tls on

tls_trust_file /etc/ssl/certs/ca-certificates.crt

logfile ~/.msmtp.log

account gmail

host smtp.gmail.com

port 587

from your gmail address

user your gmail address

password your gmail password

account default : gmail

Then copy the created msmtpru file to the folder /etc/ of the zm container as follows

sudo docker cp msmtprc myzm:/etc/msmtprc

Open http://localhost:8085/zm/ and add the camera monitors

And fill up email details under the Optons/email of the ZM-Panel

Create appropriate zm-filter to send email alerts of motion detection events

Please refer my following blog  to know about the building the image and usage

https://bkjaya.wordpress.com/2019/12/20/how-to-build-a-zoneminder-docker-image-with-msmtp-using-a-dockerfile-push-to-docker-hub-ubuntu-19-10/


Acknowledgements : Based on Zoneminder and Andrew Bauer's zonexpertconsulting@outlook.com entrypoint script

at https://raw.githubusercontent.com/ZoneMinder/zmdockerfiles/master/utils/entrypoint.sh
