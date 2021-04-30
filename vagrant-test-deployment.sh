#!/bin/bash
ansible-playbook -i kubernetes-setup/inventory/vagrant.ini kubernetes-setup/test-deployment.yml "$@"
