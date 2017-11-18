# Ansible postgresql cluster using repmgr with multi slaves

This Ansible role is used to create and manage Postgresql cluster with several slaves using repmgr.

You could have a master node and N slaves and you could set for each slave the replication upstream node.

For this role, I have used 4 vm with virtualbox and use the user edele to connect as you could see the examples in the shell script. So if you want to test it, create a VM Centos 7 with virtualbox and duplicate it for having the number of slaves you want.

## Tags

**List of the tags used and description :**

* postgresql_create_user
    * Create the postgres user and group and deploying ssh keys between the VM, manage some systems stuff (SElinux, limits, hosts, sudo)
* postgresql_create_instances
    * Install postgres binaries, enable service and firewall
* postgresql_create_repmgr
    * Install Repmgr binaries and deploying usefull sql scripts
* postgresql_configure
    * Generate password files, postgresql.conf, certificates, init the Master instance, create the databases and installting extensions
* postgresql_configure_repmgr_master
    * Create the Repmgr user and database, generate the repmgr.conf file and register the Master node in the cluster
* postgresql_configure_repmgr_slaves
    * Generate the repmgr.conf, certificates on each slave node, cloning the master to create the slaves, regenerate the repmgr.conf for setting the right upstream node and start the slaves nodes, register the slaves in the cluster
* postgresql_switchover_to_standby_node
    * Do checks before the switchover and if all is good, do the switchover to the choosen node
* postgresql_cluster_status
    * Give a status of the nodes like repmgr cluster show
* postgresql_cluster_start
    * Start the cluster
* postgresql_cluster_stop
    * Stop the cluster
* postgresql_cluster_repmgrd_status
    * Give a status of the repmgrd dameon on each node
* postgresql_cluster_repmgrd_start
    * Start repmgrd daemon
* postgresql_cluster_repmgrd_stop
    * Stop repmgrd daemon
* postgresql_cluster_replication_status
    * Give a status of cluster with the replication lag when repmgrd is running (repmgr.repl_status table)

## Variables

As they are in the **defaults/main.yml** file

```yaml
## Postgresql configuration
# Version to install
postgresql_version: "9.5"
postgresql_port: "5432"
postgresql_max_connections: "100"
postgresql_sharde_buffers: "128MB"
prostgresql_extensions: ""
postgresql_wal_keep_segments: "5"
postgresql_max_replication_slots: "{{ groups['cluster_ha'] | length }}"
postgresql_max_wal_senders: "15"

## Cluster configuration
postgresql_instance_name: "cascade"
postgresql_instance_encoding: "UTF8"
postgresql_instance_locale: "fr_FR.UTF8"
postgresql_password: "pgpwdToChange"

## Databases to create 
postgresql_databases:
  - { dbname: "test1", dbuser: "test1", dbuserpwd: "pwdToChange", dbencoding: "UTF8", dbextensions: ["plpgsql","pg_stat_statements","sslinfo"]}
  - { dbname: "test2", dbuser: "testother", dbuserpwd: "pwdToChange", dbencoding: "UTF8", dbextensions: ["plpgsql","pg_stat_statements","sslinfo"]}
  - { dbname: "test3", dbuser: "test3", dbuserpwd: "pwdToChange", dbencoding: "UTF8", dbextensions: ["plpgsql","pg_stat_statements","sslinfo"]}  

## This parameter is to force the initdb even if an instance is already present, use it carrefully, it will erase all the Cluster
postgresql_force_initdb: True

## Certificate data
postgresql_ssl_certificate_CA: "fr"
postgresql_ssl_certificate_ST: "Seine et Marne"
postgresql_ssl_certificate_L: "Melun"
postgresql_ssl_certificate_O: "Eric"
postgresql_ssl_certificate_CN: ""

## Repmgr configuration
postgresql_repmgr_password: "RepMgrPwd!"
postgresql_repmgr_monitor_interval_secs: "30"
postgresql_repmgr_master_response_timeout: "30"
postgresql_repmgr_reconnect_attempts: "3"
postgresql_repmgr_reconnect_interval: "5"

## Topology of the Cluster
# node: hostname
# node_num: number of the node
# upstream_node: hostname of the upstream node for this node
# upstream_node_num: number of the upstream node for this node
# upstream_node_num_for_creation: number of the upstream node for cloning the slave, here the Master but could be a slave
postgresql_cluster_config:
  - { node: "vm1", node_num: "1", upstream_node: "",    upstream_node_num: "",  upstream_node_num_for_creation: ""}
  - { node: "vm2", node_num: "2", upstream_node: "vm1", upstream_node_num: "1", upstream_node_num_for_creation: "1"}
  - { node: "vm3", node_num: "3", upstream_node: "vm2", upstream_node_num: "2", upstream_node_num_for_creation: "1"}  
  - { node: "vm4", node_num: "4", upstream_node: "vm3", upstream_node_num: "3", upstream_node_num_for_creation: "1"}  
```

## Usage

See the shell script **manage_cluster.sh** for usage detail, you have all the steps for creating the cluster and manage it like :
* Create master node and slaves nodes
* Start cluster
* Stop cluster
* Status of the cluster
* Switchover the master node to a standby node
* Start repmgrd daemon
* Stop repmgrd daemon
* Status of the repmgrd daemon


Author
------
Eric Deleforterie


LICENSE
------
This repository is available under "GNU GENERAL PUBLIC LICENSE" (v. 3)

http://www.gnu.org/licenses/gpl.txt

![alt text](https://www.gnu.org/graphics/gplv3-127x51.png)

