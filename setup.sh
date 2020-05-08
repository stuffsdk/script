#!/bin/bash

MACHINE_HOME="/usr/local/bin/stuffsdk"
echo 'Stuffsdk Version: 1.0.0';
echo 'Stuffsdk Installing...';
curl https://raw.githubusercontent.com/stuffsdk/script/master/stuffsdk.sh --output $MACHINE_HOME
chmod +x $MACHINE_HOME
echo 'Stuffsdk installed successfully.';
