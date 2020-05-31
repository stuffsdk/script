#!/bin/bash

VERSION='Stuffsdk Tool Script 1.1.0 (Alpha)';
function stop_server()
{
    # perform cleanup here
    echo '';
    echo "Stoping server..."
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
     echo 'Starting server...';

     if [ -e $2 ]
        then
             echo "[warning] host address is missing !"
        else
             echo http://$2;

             if [ -e .work-space/logs/stuffsdk.log ]
                then
                     echo -n "" >> .work-space/logs/stuffsdk.log
                     tail -f .work-space/logs/stuffsdk.log
                else
                     file=".work-space/logs/stuffsdk.log"
                     mkdir -p ".work-space/logs/"
                     echo -n "" >> $file
                     tail -f .work-space/logs/stuffsdk.log
             fi
     fi


   ;;
   "startproject")
     if [ -e $2 ]
        then
             echo "[warning] project name is missing !"
        else
             git clone https://github.com/stuffsdk/project.git $2 && rm -rf $2/.git
             echo "project created successfully.";
     fi
   ;;
   "createapp")
      if [ -e $2 ]
        then
             echo '[warning] app name is missing !';
        else
             #improvement required
             git clone https://github.com/stuffsdk/app-structure.git apps/$2 && rm -rf apps/$2/.git

             file=init.php
             mv apps/$2/$file apps/$2/.$file
             sed "s/{name}/${2}/g" apps/$2/.$file >> apps/$2/$file
             rm apps/$2/.$file

             file=package.json
             mv apps/$2/$file apps/$2/.$file
             sed "s/{name}/${2}/g" apps/$2/.$file >> apps/$2/$file
             rm apps/$2/.$file


             file=SampleModel.php
             mv apps/$2/models/$file apps/$2/models/.$file
             sed "s/{name}/${2}/g" apps/$2/models/.$file >> apps/$2/models/$file
             rm apps/$2/models/.$file

             file=TestUnit.php
             mv apps/$2/tests/$file apps/$2/tests/.$file
             sed "s/{name}/${2}/g" apps/$2/tests/.$file >> apps/$2/tests/$file
             rm apps/$2/tests/.$file

             echo "$2 app created successfully.";

             if [ -e index.php ]
                then
                     php index.php +app $2
                else
                     :
             fi


      fi
   ;;
   "upgrade")
      curl -s https://stuffsdk.com/setup.sh | sudo bash
   ;;
   "+app")
        if [ -e $2 ]
          then
               echo "[warning] app name is missing !"
          else
               if [ -e index.php ]
                then
                    php index.php +app $2
                else
                    echo "Unable to complete this action. Are you sure you are in project root directory?";
               fi
        fi
   ;;
   "-app")
      if [ -e $2 ]
          then
               echo "[warning] app name is missing !"
          else
               if [ -e index.php ]
                then
                    php index.php -app $2
                else
                    echo "Unable to complete this action. Are you sure you are in project root directory?";
               fi
        fi
   ;;
   "migrate")
      if [ -e index.php ]
      then
          php index.php migrate
      else
          echo "Unable to complete this action. Are you sure you are in project root directory?";
      fi
   ;;
   "createsuperuser")
      if [ -e index.php ]
      then
          echo "Enter user's email address"
          read email
          echo "Enter user's password"
          read password
          echo "Re-enter user's password"
          read repassword
          php index.php createsuperuser $email $password
      else
          echo "Unable to complete this action. Are you sure you are in project root directory?";
      fi
   ;;
   "test")
        if [ -e index.php ]
        then
             php index.php test
        else
             echo "Unable to complete this action. Are you sure you are in project root directory?";
        fi
   ;;
   "--version")
        echo "Stuffsdk Version: $VERSION";
   ;;
   *)
     echo "read more https://stuffsdk.com/stuffsdk/stuffsdk"
     exit 0
   ;;
esac
