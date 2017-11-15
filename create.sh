#!/bin/bash
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_create_user" --user=edele postgresql_ha_cascade.yml
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_create_instances" --user=edele postgresql_ha_cascade.yml
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_create_repmgr" --user=edele postgresql_ha_cascade.yml
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_configure" --user=edele postgresql_ha_cascade.yml
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_configure_repmgr_master" --user=edele postgresql_ha_cascade.yml
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_configure_repmgr_slaves" --user=edele postgresql_ha_cascade.yml

#ALL
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_create_instances,postgresql_create_repmgr,postgresql_configure,postgresql_configure_repmgr_master,postgresql_configure_repmgr_slaves" --user=edele postgresql_ha_cascade.yml

# Recreate master and slave
#ansible-playbook -i inventory/inventory.yml --tags "postgresql_configure,postgresql_configure_repmgr_master,postgresql_configure_repmgr_slaves" --user=edele postgresql_ha_cascade.yml

#Switchover to a standby node
ansible-playbook -i inventory/inventory.yml --tags "postgresql_switchover_to_standby_node" --extra-vars "postgresql_standby_node_for_switchover=vm2" --user=edele postgresql_ha_cascade.yml
