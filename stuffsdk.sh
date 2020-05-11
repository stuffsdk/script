#!/bin/bash

VERSION='1.0.2 (Beta)';
function stop_server()
{
    # perform cleanup here
    echo '';
    echo "Stoping server."
    exit 2
}

trap "stop_server" 2

case "$1" in
   "make")
     if [ -e $HOME/stuffsdk-src ]
        then
             echo 'Updating existing source...'
             cd $HOME/stuffsdk-src
             git pull
             echo 'done!';
        else
             git clone git@github.com:stuffsdk/stuffsdk.git $HOME/stuffsdk-src
             echo 'done!';
     fi
   ;;
   "runserver")
     nohup php -S $2 >/dev/null 2>&1 &
     echo "Stuffsdk Version: $VERSION";
     echo 'Server started.';
     echo http://$2;
     tail -f -n 1 .work-space/logs/stuffsdk.log
   ;;
   "startproject")
     git clone https://github.com/stuffsdk/project.git $2
     echo "project created successfully.";
   ;;
   "upgrade")
      curl -s https://stuffsdk.com/setup.sh | sudo bash
   ;;
   *)
     echo "Stuffsdk Version: $VERSION";
   ;;
esac
