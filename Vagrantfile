# -*- mode: ruby -*-
# vi: set ft=ruby :

#The cluster will start with 2 agent nodes by default. You can tune the
#number of agent nodes by passing an enviornment variable for K3S_AGENTS

number_of_etcd = (ENV['K3S_ETCDS'] || "1").to_i
number_of_servers = (ENV['K3S_SERVERS'] || "2").to_i
number_of_agents = (ENV['K3S_AGENTS'] || "1").to_i
number_of_storages = (ENV['K3S_STORAGE'] || "1").to_i
box_name = (ENV['VAGRANT_BOX'] || "ubuntu/bionic64")
Vagrant.configure("2") do |config|

  # multi-master LB
  config.vm.define "master_lb" do |haproxy|
    haproxy.vm.box = "#{box_name}"
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network "public_network", bridge: "wlo1", ip: "192.168.1.20"

    haproxy.vm.provider :virtualbox do |vbox|
      vbox.customize ["modifyvm", :id, "--memory", 1024]
      vbox.customize ["modifyvm", :id, "--cpus", 1]
    end

    haproxy.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/haproxy/haproxy-setup.yaml"
    end

    # haproxy.vm.network "forwarded_port", guest: 6443, host: 6443
    # haproxy.vm.provision "file", source: "scripts/haproxy/haproxy.cfg", destination: "/tmp/haproxy.cfg"
    # haproxy.vm.provision "shell", privileged: true,  path: "scripts/haproxy/install_happroxy.sh"
  end

  # etcd
  (0..number_of_etcd-1).each do |machine_id|
    config.vm.define "etcd#{machine_id}" do |machine|
      machine.vm.box = "#{box_name}"
      machine.vm.hostname = "etcd#{machine_id}"
      machine.vm.network "public_network", bridge: "wlo1", ip: "192.168.1.10#{machine_id}"

      machine.vm.provider :virtualbox do |vbox|
        vbox.customize ["modifyvm", :id, "--memory", 1024]
        vbox.customize ["modifyvm", :id, "--cpus", 1]
        # vbox.customize ["modifyvm", :id, "--cableconnected1", "on"]
      end

      # if machine_id == number_of_etcd-1
      machine.vm.provision :ansible do |ansible|
          ansible.playbook = "ansible/etcd/etcd-setup.yaml"
      end
      # end
    end
  end

  # master
  (0..number_of_servers-1).each do |server_id|
    config.vm.define "master#{server_id}" do |master|
      master.vm.box = "#{box_name}"
      master.vm.hostname = "master#{server_id}"
      master.vm.network "public_network", bridge: "wlo1", ip: "192.168.1.11#{server_id}"
      master.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
          # vbox.customize ["modifyvm", :id, "--cableconnected1", "on"]
      end
      
      if server_id == 0
        master.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/k3s/master-setup.yaml"
        end  
      else
        master.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/k3s/master-join.yaml"
        end  
      end
    end
  end

  # agents
  (0..number_of_agents-1).each do |node_number|
    config.vm.define "agent#{node_number}" do |agent|
      agent.vm.box = "#{box_name}"
      agent.vm.hostname = "agent#{node_number}"
      agent.vm.network "public_network", bridge: "wlo1", ip: "192.168.1.12#{node_number}"
      agent.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
          # vbox.customize ["modifyvm", :id, "--cableconnected1", "on"]
      end
      agent.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/k3s/agent-setup.yaml"
      end
    end
  end

  # storage agents
  # requirement: create partitions first names sda<num> (i.e. /dev/sda1, /dev/sda2, ...)
  (0..number_of_storages-1).each do |storage_number|
    config.vm.define "storage#{storage_number}" do |storage|
      storage.vm.synced_folder "/mnt/sda#{storage_number+1}", "/mnt/sda#{storage_number+1}", type: "virtualbox"
      storage.vm.box = "#{box_name}"
      storage.vm.hostname = "storage#{storage_number}"
      storage.vm.network "public_network", bridge: "wlo1", ip: "192.168.1.13#{storage_number}"
      storage.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
          # vbox.customize ["modifyvm", :id, "--cableconnected1", "on"]
      end
      storage.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/k3s/storage-setup.yaml"
      end
    end
  end
  
  # TODO: load balancer for multi-master setup

end
