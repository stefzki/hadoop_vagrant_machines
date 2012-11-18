# Hadoop Vagrant definitions

##ATTENTION

At the moment these scripts are work in progress - i will remove this info, when i am finished :)

## Purpose

I personally liked Hadoop and all it's technologies. After it was great doing a live demo with a MongoDB Sharding Cluster, i thought it may also be funny to have something like this for Hadoop clusters.

## Preconditions

Please follow the install instructions at http://vagrantup.com/. Use the latest version from vagrant and install the latest version of VirtualBox (the version from the projects homepages are recommended). After the installation, verify that virtualization options are enabled in your bios, if you are using a 'normal' pc. We did not encounter any virtualization problems on macs. Furthermore you'll need a downloaded JDK for Linux 64bit (downloadable at http://www.oracle.com/technetwork/java/javase/downloads/index.html).

## The machines

### simple-hadoop

This is a simple three machines CDH4 Hadoop cluster setup. It does just contain Hadoop (namenode, jobtracker, datanode and tasktracker). It uses a standard Ubuntu base-box and installs mongo via puppet. 

Usage:
``` 
cd simple-hadoop
vagrant up
```

After all three machines are on, you can reach the following webinterfaces to check if everything did work:

- namenode: http://namenode.local:50070/dfshealth.jsp
- jobtracker: http://namenode.local:50030/jobtracker.jsp
- datanode at node01: http://datanode01.local:50075/browseDirectory.jsp?namenodeInfoPort=50070&dir=%2F&nnaddr=12.0.0.23:8020
- tasktracker at node01: http://datanode01.local:50060/tasktracker.jsp
- datanode at node02: http://datanode02.local:50075/browseDirectory.jsp?namenodeInfoPort=50070&dir=%2F&nnaddr=12.0.0.23:8020
- tasktracker at node02: http://datanode02.local:50060/tasktracker.jsp

To shut down the vagrant images use:

```
vagrant halt
```
or

```
vagrant destroy
```