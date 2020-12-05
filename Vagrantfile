IMAGE_NAME = "ubuntu/focal64"
VAGRANT_VM_PROVIDER = "virtualbox"
MASTERS = 1
NODES = 2
INVENTORY = "kubernetes-setup/inventory/vagrant.ini"
PLAYBOOK = "kubernetes-setup/cluster.yml"

MASTER_RAW_SSH_ARGS = []
NODE_RAW_SSH_ARGS = []

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    (1..MASTERS-1).each do |machine_id|
       MASTER_RAW_SSH_ARGS << "-o IdentityFile=#{ENV["VAGRANT_DOTFILE_PATH"]}/machines/machine#{machine_id}/#{VAGRANT_VM_PROVIDER}/private_key"
    end

    (1..NODES-1).each do |machine_id|
       NODE_RAW_SSH_ARGS << "-o IdentityFile=#{ENV["VAGRANT_DOTFILE_PATH"]}/machines/machine#{machine_id}/#{VAGRANT_VM_PROVIDER}/private_key"
    end

    (1..MASTERS).each do |i|
        config.vm.define "master-#{i}" do |master|
            master.vm.box = IMAGE_NAME
            master.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            master.vm.hostname = "master#{i}.vagrant.local"
            if i == MASTERS
                master.vm.provision "ansible" do |ansible|
                    ansible.limit = "master"
                    ansible.inventory_path = INVENTORY
                    ansible.playbook = PLAYBOOK
                    ansible.raw_ssh_args = MASTER_RAW_SSH_ARGS
                end
            end
        end
    end

    (1..NODES).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 20}"
            node.vm.hostname = "node#{i}.vagrant.local"
            if i == NODES
                node.vm.provision "ansible" do |ansible|
                    ansible.limit = "node"
                    ansible.inventory_path = INVENTORY
                    ansible.playbook = PLAYBOOK
                    ansible.raw_ssh_args = NODE_RAW_SSH_ARGS
                end
            end
        end
    end
end
