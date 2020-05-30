RAC COMMANDS.sql

./createRAC -r rac2 -N NAT2 -s 1 -n 2

./runInstaller -silent -responseFile /u01/app/oracle/product/18.0.0/dbhome_1/db_swonly.rsp -waitForCompletion -ignorePrereq

./runInstaller -silent -responseFile /u01/DB_INSTALLERS/db121/db_swonly.rsp -showProgress -ignorePrereq

./runInstaller -silent -responseFile /u01/DB_INSTALLERS/db122/db_swonly.rsp -showProgress -ignorePrereq


virsh destroy rac2-node1 ; virsh destroy rac2-node2 ;  virsh undefine rac2-node2 ; virsh undefine rac2-node1 ; virsh destroy rac2-nfs1 ; virsh undefine rac2-nfs1 ; /home/solifugo/RAC-INSTALLER/root/deleteNetwork NAT1virsh destroy rac2-node1 ; virsh destroy rac2-node2 ;  virsh undefine rac2-node2 ; virsh undefine rac2-node1 ; virsh destroy rac2-nfs1 ; virsh undefine rac2-nfs1 ; /home/solifugo/RAC-INSTALLER/root/deleteNetwork NAT1virsh destroy rac2-node1 ; virsh destroy rac2-node2 ;  virsh undefine rac2-node2 ; virsh undefine rac2-node1 ; virsh destroy rac2-nfs1 ; virsh undefine rac2-nfs1 ; /home/solifugo/RAC-INSTALLER/ol7_19c/root/deleteNetwork NAT1





dbca -silent -deleteDatabase -sourceDB db112


/u01/app/oracle/product/19.3.0/dbhome_1/bin/dbca -silent -deleteDatabase -sourceDB rac2cdb1

-- Create SLIM Databases:


nohup time /u01/app/oracle/product/19.3.0/dbhome_1/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName reco19  \
-sid reco19  \
-createAsContainerDatabase true \
-numberOfPdbs 1 \
-pdbName pdb_reco19 \
-pdbAdminPassword Welcome1 \
-SysPassword Welcome1 \
-SystemPassword Welcome1 \
-emConfiguration NONE \
-storageType ASM \
-redoLogFileSize 200 \
-diskGroupName DATA \
-recoveryAreaDestination +RECO \
-enableArchive true \
-archiveLogMode auto \
-characterSet AL32UTF8 \
-nationalCharacterSet AL16UTF16 \
-databaseType MULTIPURPOSE \
-sampleschema false \
-ignorePreReqs \
-nodelist rac1-node1,rac1-node2 \
-dbOptions JSERVER:true,ORACLE_TEXT:false,IMEDIA:false,CWMLITE:false,SPATIAL:false,OMS:false,APEX:false,DV:false &


nohup time /u01/app/oracle/product/11.2.0/dbhome_1/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName reco11  \
-sid reco11  \
-SysPassword Welcome1 \
-SystemPassword Welcome1 \
-emConfiguration NONE \
-storageType ASM \
-redoLogFileSize 200 \
-diskGroupName DATA \
-recoveryAreaDestination +RECO \
-enableArchive true \
-archiveLogMode auto \
-characterSet AL32UTF8 \
-nationalCharacterSet AL16UTF16 \
-databaseType MULTIPURPOSE \
-sampleschema false \
-ignorePreReqs \
-nodelist rac1-node1,rac1-node2 \
-dbOptions JSERVER:true,ORACLE_TEXT:false,IMEDIA:false,CWMLITE:false,SPATIAL:false,OMS:false,APEX:false,DV:false &


-- Create Databases:

/u01/app/oracle/product/19.3.0/dbhome_1/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName cdb19  \
-sid cdb19  \
-createAsContainerDatabase true \
-numberOfPdbs 2 \
-pdbName pdb19 \
-pdbAdminPassword Welcome1 \
-SysPassword Welcome1 \
-SystemPassword Welcome1 \
-storageType ASM \
-redoLogFileSize 200  \
-diskGroupName DATA \
-characterSet AL32UTF8 \
-nationalCharacterSet AL16UTF16 \
-databaseType MULTIPURPOSE \
-sampleschema false \
-ignorePreReqs \
-nodelist rac1-node1,rac1-node2




/u01/app/oracle/product/12.2.0/dbhome_1/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName db122  \
-sid db122  \
-SysPassword Welcome1 \
-SystemPassword Welcome1 \
-emConfiguration NONE \
-storageType ASM \
-diskGroupName DATA12 \
-characterSet AL32UTF8 \
-nationalCharacterSet AL16UTF16 \
-databaseType MULTIPURPOSE \
-sampleschema true \
-ignorePreReqs \
-nodelist rac1-node1,rac1-node2



/u01/app/oracle/product/12.2.0/dbhome_1/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName cdb122  \
-sid cdb122  \
-createAsContainerDatabase true \
-numberOfPdbs 2 \
-pdbName pdb122 \
-pdbAdminPassword Welcome1 \
-SysPassword Welcome1 \
-SystemPassword Welcome1 \
-emConfiguration NONE \
-storageType ASM \
-redoLogFileSize 50  \
-diskGroupName DATA12 \
-characterSet AL32UTF8 \
-nationalCharacterSet AL16UTF16 \
-databaseType MULTIPURPOSE \
-sampleschema false \
-ignorePreReqs \
-nodelist rac1-node1,rac1-node2





-- add the disks to the diskgroup

-- Add the disks to the NFS server:


qemu-img create -f raw /nfsshares/nfs1-disk17 5G;
qemu-img create -f raw /nfsshares/nfs1-disk18 5G;
qemu-img create -f raw /nfsshares/nfs1-disk19 5G;
qemu-img create -f raw /nfsshares/nfs1-disk20 5G;
chown oracle:oinstall -R /nfsshares/
chmod 775 -R /nfsshares/
cat /etc/exports
/etc/init.d/nfs restart


sqlplus as sysasm

set lines 500
set pages 50
col path for a60
select
   mount_status,
   header_status,
   mode_status,
   state,
   total_mb,
   free_mb,
   name,
   path
from
   v$asm_disk
where header_status = 'CANDIDATE';


MOUNT_S HEADER_STATU MODE_ST STATE      TOTAL_MB    FREE_MB NAME                           PATH
------- ------------ ------- -------- ---------- ---------- ------------------------------ ------------------------------------------------------------
CLOSED  CANDIDATE    ONLINE  NORMAL            0          0                                /u01/oradata/nfs1/nfs1-disk23
CLOSED  CANDIDATE    ONLINE  NORMAL            0          0                                /u01/oradata/nfs1/nfs1-disk24
CLOSED  CANDIDATE    ONLINE  NORMAL            0          0                                /u01/oradata/nfs1/nfs1-disk22
CLOSED  CANDIDATE    ONLINE  NORMAL            0          0                                /u01/oradata/nfs1/nfs1-disk25

SQL> ALTER DISKGROUP DATA ADD DISK '/u01/oradata/nfs1/nfs1-disk22';

Diskgroup altered.

SQL> ALTER DISKGROUP DATA ADD DISK '/u01/oradata/nfs1/nfs1-disk23';

Diskgroup altered.

SQL> ALTER DISKGROUP DATA ADD DISK '/u01/oradata/nfs1/nfs1-disk24';

Diskgroup altered.

SQL> ALTER DISKGROUP DATA ADD DISK '/u01/oradata/nfs1/nfs1-disk25';

Diskgroup altered.


-- Check rebalance (since this diskgroup has normal mirroring)

SQL> show parameter asm_power_limit;

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
asm_power_limit                      integer     1
SQL> select * from gv$asm_operation;

   INST_ID GROUP_NUMBER OPERA PASS      STAT      POWER     ACTUAL      SOFAR   EST_WORK   EST_RATE EST_MINUTES ERROR_CODE                                       CON_ID
---------- ------------ ----- --------- ---- ---------- ---------- ---------- ---------- ---------- ----------- -------------------------------------------- ----------
         1            4 REBAL COMPACT   WAIT          1          1          0          0          0           0                                                       0
         1            4 REBAL REBALANCE RUN           1          1          0       2513          0           0                                                       0
         1            4 REBAL REBUILD   DONE          1          1          0          0          0           0                                                       0
         1            4 REBAL RESYNC    DONE          1          1          0          0          0           0                                                       0
         2            4 REBAL COMPACT   WAIT          1                                                                                                               0
         2            4 REBAL REBALANCE WAIT          1                                                                                                               0
         2            4 REBAL REBUILD   WAIT          1                                                                                                               0
         2            4 REBAL RESYNC    WAIT          1                                                                                                               0

8 rows selected.

SQL>

-- Force a faster rebalance (since we have all DBs down)


SQL> ALTER DISKGROUP DATA REBALANCE POWER  1024 NOWAIT;

Diskgroup altered.

SQL> select * from gv$asm_operation;

   INST_ID GROUP_NUMBER OPERA PASS      STAT      POWER     ACTUAL      SOFAR   EST_WORK   EST_RATE EST_MINUTES ERROR_CODE                                       CON_ID
---------- ------------ ----- --------- ---- ---------- ---------- ---------- ---------- ---------- ----------- -------------------------------------------- ----------
         1            4 REBAL COMPACT   WAIT       1024       1024          0          0          0           0                                                       0
         1            4 REBAL REBALANCE RUN        1024       1024         22       1094       2443           0                                                       0
         1            4 REBAL REBUILD   DONE       1024       1024          0          0          0           0                                                       0
         1            4 REBAL RESYNC    DONE       1024       1024          0          0          0           0                                                       0
         2            4 REBAL COMPACT   WAIT       1024                                                                                                               0
         2            4 REBAL REBALANCE WAIT       1024                                                                                                               0
         2            4 REBAL REBUILD   WAIT       1024                                                                                                               0
         2            4 REBAL RESYNC    WAIT       1024                                                                                                               0

8 rows selected.

SQL>













asmca -silent -creatediskgroup -diskGroupName RECO \
-disk '/u01/oradata/nfs1/nfs1-disk6' \
-disk '/u01/oradata/nfs1/nfs1-disk7' \
-disk '/u01/oradata/nfs1/nfs1-disk8' \
-disk '/u01/oradata/nfs1/nfs1-disk9' \
-disk '/u01/oradata/nfs1/nfs1-disk10' \
-redundancy External -compatible.asm '11.2.0.2.0' -compatible.rdbms '11.2.0.2.0'



[oracle@rac1-node1 ~]$ asmca -silent -creatediskgroup -diskGroupName RECO \
> -disk '/u01/oradata/nfs1/nfs1-disk6' \
> -disk '/u01/oradata/nfs1/nfs1-disk7' \
> -disk '/u01/oradata/nfs1/nfs1-disk8' \
> -disk '/u01/oradata/nfs1/nfs1-disk9' \
> -disk '/u01/oradata/nfs1/nfs1-disk10' \
> -redundancy External -compatible.asm '11.2.0.2.0' -compatible.rdbms '11.2.0.2.0'

[INFO] [DBT-30001] Disk groups created successfully. Check /u01/app/grid/cfgtoollogs/asmca/asmca-191019PM041025.log for details.


[oracle@rac1-node1 ~]$ asmca -silent -creatediskgroup -diskGroupName DATA11 \
> -disk '/u01/oradata/nfs1/nfs1-disk11' \
> -disk '/u01/oradata/nfs1/nfs1-disk12' \
> -disk '/u01/oradata/nfs1/nfs1-disk13' \
> -redundancy External -compatible.asm '11.2.0.2.0' -compatible.rdbms '11.2.0.2.0'

[INFO] [DBT-30001] Disk groups created successfully. Check /u01/app/grid/cfgtoollogs/asmca/asmca-191019PM044101.log for details.


[oracle@rac1-node1 ~]$ asmca -silent -creatediskgroup -diskGroupName DATA12 \
> -disk '/u01/oradata/nfs1/nfs1-disk14' \
> -disk '/u01/oradata/nfs1/nfs1-disk15' \
> -disk '/u01/oradata/nfs1/nfs1-disk16' \
> -disk '/u01/oradata/nfs1/nfs1-disk17' \
> -redundancy External -compatible.asm '12.1.0.0.0' -compatible.rdbms '12.1.0.0.0'

[INFO] [DBT-30001] Disk groups created successfully. Check /u01/app/grid/cfgtoollogs/asmca/asmca-191019PM044434.log for details.


[oracle@rac1-node1 ~]$


asmca -silent -creatediskgroup -diskGroupName DATA18 \
-disk '/u01/oradata/nfs1/nfs1-disk18' \
-disk '/u01/oradata/nfs1/nfs1-disk19' \
-disk '/u01/oradata/nfs1/nfs1-disk20' \
-redundancy External -compatible.asm '18.0' -compatible.rdbms '18.0'







-- To communicate 2 RACs, create network:



[oracle@rac5-node1 ~]$ cat /etc/sysconfig/network-scripts/route-eth0
GATEWAY0=192.168.1.1
NETMASK0=255.255.255.192
ADDRESS0=192.168.2.0
[oracle@rac5-node1 ~]$ ssh rac5-node2 "cat /etc/sysconfig/network-scripts/route-eth0"
GATEWAY0=192.168.2.1
NETMASK0=255.255.255.192
ADDRESS0=192.168.1.0
[oracle@rac5-node1 ~]$




[oracle@rac5-node1 ~]$ ip route
169.254.0.0/16 dev eth1  proto kernel  scope link  src 169.254.90.146
192.168.4.0/26 via 192.168.5.1 dev eth0
192.168.5.0/26 dev eth0  proto kernel  scope link  src 192.168.5.11
192.168.5.64/27 dev eth1  proto kernel  scope link  src 192.168.5.71
192.168.5.96/27 dev eth2  proto kernel  scope link  src 192.168.5.101
[oracle@rac5-node1 ~]$


iptables -D FORWARD -o virbr1 -j REJECT --reject-with icmp-port-unreachable
iptables -D FORWARD -i virbr1 -j REJECT --reject-with icmp-port-unreachable
iptables -D FORWARD -o virbr2 -j REJECT --reject-with icmp-port-unreachable
iptables -D FORWARD -i virbr2 -j REJECT --reject-with icmp-port-unreachable






-- Add CRS flag to Inventory.xml as follow so the DB installation can find the 2 nodes:



[oracle@rac1-node1 grid]$ cp -p /u01/app/oraInventory/ContentsXML/inventory.xml /u01/app/oraInventory/ContentsXML/inventory.xml.bk2
[oracle@rac1-node1 grid]$ /u01/app/18.0.0/grid/oui/bin/runInstaller -silent -ignoreSysPrereqs -updateNodeList ORACLE_HOME="/u01/app/18.0.0/grid"  "CLUSTER_NODES={rac1-node1,rac1-node2}" CRS=true
Starting Oracle Universal Installer...

Checking swap space: must be greater than 500 MB.   Actual 2047 MB    Passed
The inventory pointer is located at /etc/oraInst.loc
'UpdateNodeList' was successful.
[oracle@rac1-node1 grid]$ diff /u01/app/oraInventory/ContentsXML/inventory.xml /u01/app/oraInventory/ContentsXML/inventory.xml.bk2
2c2
< <!-- Copyright (c) 1999, 2019, Oracle and/or its affiliates.
---
> <!-- Copyright (c) 1999, 2013, Oracle and/or its affiliates.
7c7
<    <SAVED_WITH>12.2.0.4.0</SAVED_WITH>
---
>    <SAVED_WITH>11.2.0.4.0</SAVED_WITH>
11,16c11
< <HOME NAME="OraGI18Home1" LOC="/u01/app/18.0.0/grid" TYPE="O" IDX="1" CRS="true">
<    <NODE_LIST>
<       <NODE NAME="rac1-node1"/>
<       <NODE NAME="rac1-node2"/>
<    </NODE_LIST>
< </HOME>
---
> <HOME NAME="OraGI18Home1" LOC="/u01/app/18.0.0/grid" TYPE="O" IDX="1" CRS="true"/>
[oracle@rac1-node1 grid]$ 




/u01/app/19.3.0/grid/oui/bin/runInstaller -silent -ignoreSysPrereqs -updateNodeList ORACLE_HOME="/u01/app/19.3.0/grid"  "CLUSTER_NODES={rac1-node1,rac1-node2}" CRS=true


-- Create a response file for "Software only"
** You can do both in this step, but this way, you only create the DB in the primary Cluster, and only the software in your Standby Cluster

## db_swonly.rsp ##
oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v11_2_0
oracle.install.option=INSTALL_DB_SWONLY
UNIX_GROUP_NAME=oinstall
INVENTORY_LOCATION=/u01/app/oraInventory
SELECTED_LANGUAGES=en,en_GB
ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
ORACLE_BASE=/u01/app/oracle
oracle.install.db.InstallEdition=EE
oracle.install.db.EEOptionsSelection=false
oracle.install.db.DBA_GROUP=oinstall
oracle.install.db.isRACOneInstall=false
oracle.install.db.config.starterdb.type=GENERAL_PURPOSE
oracle.install.db.config.starterdb.memoryOption=false
oracle.install.db.config.starterdb.installExampleSchemas=false
oracle.install.db.config.starterdb.enableSecuritySettings=true
oracle.install.db.config.starterdb.automatedBackup.enable=false
oracle.install.db.CLUSTER_NODES=rac1-node1,rac1-node2
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
DECLINE_SECURITY_UPDATES=true
oracle.installer.autoupdates.option=SKIP_UPDATES




-- Start Installer in silent mode with db_swonly.rsp as reponse file:

[oracle@rac1-node1 database_11.2]$ ./runInstaller -silent -responseFile /u01/Installers/database_11.2/db_swonly.rsp -showProgress -ignorePrereq
Starting Oracle Universal Installer...

Checking Temp space: must be greater than 120 MB.   Actual 77259 MB    Passed
Checking swap space: must be greater than 150 MB.   Actual 6846 MB    Passed
Preparing to launch Oracle Universal Installer from /tmp/OraInstall2018-12-14_09-18-49PM. Please wait ...[oracle@rac1-node1 database_11.2]$ You can find the log of this install session at:
 /u01/app/oraInventory/logs/installActions2018-12-14_09-18-49PM.log

Prepare in progress.
..................................................   9% Done.

Prepare successful.

[......]

Execute Root Scripts in progress.

As a root user, execute the following script(s):
	1. /u01/app/oracle/product/11.2.0/dbhome_1/root.sh

Execute /u01/app/oracle/product/11.2.0/dbhome_1/root.sh on the following nodes:
[rac1-node1, rac1-node2]

..................................................   100% Done.

Execute Root Scripts successful.
Successfully Setup Software.


[root@rac1-node1 ~]# /u01/app/oracle/product/11.2.0/dbhome_1/root.sh
Check /u01/app/oracle/product/11.2.0/dbhome_1/install/root_rac1-node1.raclab.local_2018-12-14_21-31-46.log for the output of root script


[root@rac1-node2 ~]# /u01/app/oracle/product/11.2.0/dbhome_1/root.sh
Check /u01/app/oracle/product/11.2.0/dbhome_1/install/root_rac1-node2.raclab.local_2018-12-14_21-31-59.log for the output of root script
[root@rac1-node2 ~]#




-- Create DB using DBCA
** You can do both in previous step, but this way, you only create the DB in the primary Cluster, and only the software in your Standby Cluster



[oracle@rac1-node1 bin]$ 

/u01/app/oracle/product/11.2.0/dbhome_1/bin/dbca -silent \
-createDatabase \
-templateName General_Purpose.dbc \
-gdbName db112  \
-sid db112  \
-SysPassword Welcome1 \
-SystemPassword Welcome1 \
-emConfiguration NONE \
-storageType ASM \
-redoLogFileSize 50  \
-diskGroupName DATA11 \
-characterSet AL32UTF8 \
-nationalCharacterSet AL32UTF8 \
-automaticMemoryManagement true \
-memoryPercentage 20 \
-databaseType MULTIPURPOSE \
-nodelist rac1-node1,rac1-node2




alter pluggable database all open instances=all;


ALTER PLUGGABLE DATABASE pdb1211 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb1212 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb1221 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb1222 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb181 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb182 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb191 SAVE STATE;
ALTER PLUGGABLE DATABASE pdb192 SAVE STATE;

set lines 500
set pages 40
col CON_NAME for a20
col instance_name for a20
SELECT con_name, instance_name, state FROM dba_pdb_saved_states;

