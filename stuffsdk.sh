#!/bin/bash

VERSION='1.0.3 (Beta)';
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
     if [ -e .work-space/logs/stuffsdk.log ]
        timestamp=$(date +%d-%m-%Y_%H_%M_%S)
        then
             echo "Server Started "$timestamp"..." >> .work-space/logs/stuffsdk.log
             tail -f .work-space/logs/stuffsdk.log
        else
             file=".work-space/logs/stuffsdk.log"
             mkdir ".work-space/logs/"
             echo "creating log file..."
             echo "Server Started "$timestamp"..." >> $file
             tail -f .work-space/logs/stuffsdk.log
     fi

   ;;
   "startproject")
     git clone https://github.com/stuffsdk/project.git $2
     echo "project created successfully.";
   ;;
   "upgrade")
      curl -s https://stuffsdk.com/setup.sh | sudo bash
   ;;
  "migrate")
      if [ -e index.php ]
      then
          php index.php migrate
      else
          echo "Can't run migrate here entry point is missing please make sure you run test on your project root.";
      fi
   ;;
  "test")
        if [ -e index.php ]
        then
             php index.php test
        else
             echo "Can't run test here entry point is missing please make sure you run test on your project root.";
        fi
   ;;
   *)
     echo "Stuffsdk Version: $VERSION";
   ;;
esac
