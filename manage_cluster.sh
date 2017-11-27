#!/bin/bash

# Create user
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_create_user" --user=edele postgresql_ha_cascade.yml

# Postgresql installation
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_create_instances" --user=edele postgresql_ha_cascade.yml

# Repmgr installation
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_create_repmgr" --user=edele postgresql_ha_cascade.yml

# Create instance and databases
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_configure" --user=edele postgresql_ha_cascade.yml

# Configure the Master and register it in the Cluster
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_configure_repmgr_master" --user=edele postgresql_ha_cascade.yml

# Clone the Master to create all the Slaves and register them in the Cluster
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_configure_repmgr_slaves" --user=edele postgresql_ha_cascade.yml

# Reinit all the : Master and Slaves, use it with precotion as this will erase all your databases
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_create_instances,postgresql_create_repmgr,postgresql_configure,postgresql_configure_repmgr_master,postgresql_configure_repmgr_slaves" --user=edele postgresql_ha_cascade.yml

# Recreate master and slave
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_configure,postgresql_configure_repmgr_master,postgresql_configure_repmgr_slaves" --user=edele postgresql_ha_cascade.yml

#Switchover to a standby node
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_switchover_to_standby_node" --extra-vars "postgresql_standby_node_for_switchover=vm1" --user=edele postgresql_ha_cascade.yml

# Cluster status
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_status" --user=edele postgresql_ha_cascade.yml

# Cluster stop
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_stop" --user=edele postgresql_ha_cascade.yml

# Cluster start
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_start" --user=edele postgresql_ha_cascade.yml

# Cluster Repmgrd Daemon start
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_repmgrd_start" --user=edele postgresql_ha_cascade.yml

# Cluster Repmgrd Daemon status
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_repmgrd_status" --user=edele postgresql_ha_cascade.yml

# Cluster Repmgrd Daemon stop
#ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_repmgrd_stop" --user=edele postgresql_ha_cascade.yml

# Cluster replication status
ansible-playbook -i inventory/inventory.yml --extra-vars "state=postgresql_cluster_replication_status" --user=edele postgresql_ha_cascade.yml