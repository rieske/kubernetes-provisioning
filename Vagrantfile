IMAGE_NAME = "generic/ubuntu2004"
VMS = 4

sshKey="#{Dir.home}/.ssh/id_ed25519.pub"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "libvirt" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    (1..VMS).each do |i|
        config.vm.define "node#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.network "forwarded_port", guest: 443, host: 6443, auto_correct: true
            node.vm.hostname = "node#{i}.vagrant.local"
            config.vm.synced_folder '.', '/vagrant', disabled: true
            config.vm.provision "shell" do |s|
              ssh_pub_key = File.readlines("#{sshKey}").first.strip
              s.inline = <<-SHELL
                echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
                mkdir -p /root/.ssh && chmod 700 /root/.ssh
                touch /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys
                echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
              SHELL
            end
        end
    end
end
