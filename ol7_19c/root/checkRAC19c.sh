#!/bin/bash
mynet=$1
vmnode=$2

sshpass -p 'Welcome1' ssh -o StrictHostKeyChecking=no oracle@192.168.$mynet.1$vmnode '. grid19c.env && crsctl stat res -t -w "TYPE = ora.database.type" '

exit
