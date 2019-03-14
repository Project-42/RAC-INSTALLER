#!/bin/bash

mynodes=(nfs1 node1 node2)
snapshotname=

if [ "$1" = "revert" ]; then
for i in ${!mynodes[*]}
do
	snapshotname=$(virsh snapshot-list ${mynodes[$i]} | tail -2|awk '{print $1}')
	echo "reverting snapshot $snapshotname for node ${mynodes[$i]}"
	virsh snapshot-revert ${mynodes[$i]} $snapshotname 
done

else
	if [ "$1" = "backup" ]; then
		for i in ${!mynodes[*]}
		do
			echo "Taking snapshot for node ${mynodes[$i]}"
        		virsh snapshot-create ${mynodes[$i]} 
		done
	fi
fi
