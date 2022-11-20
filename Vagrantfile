# -*- mode: ruby -*-
# vi: set ft=ruby :

#The cluster will start with 2 agent nodes by default. You can tune the
#number of agent nodes by passing an enviornment variable for K3S_AGENTS

number_of_agents = (ENV['K3S_AGENTS'] || "1").to_i
number_of_storage_agents = (ENV['K3S_STORAGE'] || "1").to_i
box_name = (ENV['VAGRANT_BOX'] || "ubuntu/focal64")
Vagrant.configure("2") do |config|

    # etcd
    number_of_etcd = 1
    (0..number_of_etcd-1).each do |machine_id|
      config.vm.define "etcd#{machine_id}" do |machine|
        machine.vm.box = "#{box_name}"
        # machine.vbguest.installer_options = { allow_kernel_upgrade: true }
        machine.vm.hostname = "etcd#{machine_id}"
        machine.vm.network "public_network", bridge: "wlo1"

        machine.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
        end

        # if machine_id == number_of_etcd-1
        machine.vm.provision :ansible do |ansible|
            ansible.playbook = "ansible/etcd/etcd-setup.yaml"
        end
        # end
      end
    end

  # master
  config.vm.define "master" do |master|
    master.vm.box = "#{box_name}"
    master.vm.hostname = 'master'
    master.vm.network "public_network", bridge: "wlo1"
    master.vm.provider :virtualbox do |vbox|
        vbox.customize ["modifyvm", :id, "--memory", 1024]
        vbox.customize ["modifyvm", :id, "--cpus", 1]
    end

    master.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/k3s/master-setup.yaml"
    end
  end

  # agents
  (0..number_of_agents-1).each do |node_number|
    config.vm.define "agent#{node_number}" do |agent|
      agent.vm.box = "#{box_name}"
      agent.vm.hostname = "agent#{node_number}"
      agent.vm.network "public_network", bridge: "wlo1"
      agent.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
      end
      agent.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/k3s/agent-setup.yaml"
      end
    end
  end

  # storage agents
  (0..number_of_storage_agents-1).each do |storage_number|
    config.vm.define "storage#{storage_number}" do |storage|
    config.vm.synced_folder "/mnt/sda#{storage_number+1}", "/mnt/sda#{storage_number+1}", type: "virtualbox"
    storage.vm.box = "#{box_name}"
      storage.vm.hostname = "storage#{storage_number}"
      storage.vm.network "public_network", bridge: "wlo1"
      storage.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
      end
      storage.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/k3s/agent-setup.yaml"
      end
    end
  end

  
  # TODO: load balancer for multi-master setup

end
