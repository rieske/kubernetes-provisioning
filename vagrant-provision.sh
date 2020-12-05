#!/bin/bash
ansible-playbook -e "ansible_user=vagrant" -i kubernetes-setup/inventory/vagrant.ini kubernetes-setup/cluster.yml
