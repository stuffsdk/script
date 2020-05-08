#!/bin/bash


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
     php -S localhost:8015
   ;;
   "startproject")
     git clone https://github.com/stuffsdk/project.git $2
     echo "project created successfully.";
   ;;
   *)
     echo "Stuffsdk Version: 1.0.0";
   ;;
esac
