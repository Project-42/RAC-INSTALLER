#!/bin/bash
mynet=$1
vmnode=$2

sshpass -p 'Welcome1' ssh -o StrictHostKeyChecking=no root@192.168.$mynet.1$vmnode '/etc/init.d/db18Install'

exit
