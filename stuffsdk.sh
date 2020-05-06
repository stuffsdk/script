#!/bin/bash


case "$1" in
   "make")
     if [ -e $HOME/stuffsdk-src ]
        then
             git pull
             echo 'done!';
        else
             git clone git@github.com:stuffsdk/stuffsdk.git $HOME/stuffsdk-src
             echo 'done!';
     fi
   ;;
   "runserver")
     php -S localhost:1508
   ;;
   "startproject")
     git clone https://github.com/stuffsdk/project.git $2
     echo "project created successfully.";
   ;;
   *)
     echo "Stuffsdk Version: 1.0.0";
   ;;
esac
