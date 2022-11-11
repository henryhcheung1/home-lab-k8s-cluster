# -*- mode: ruby -*-
# vi: set ft=ruby :

#The cluster will start with 2 agent nodes by default. You can tune the
#number of agent nodes by passing an enviornment variable for K3S_AGENTS

number_of_agents = (ENV['K3S_AGENTS'] || "1").to_i
box_name = (ENV['VAGRANT_BOX'] || "ubuntu/focal64")
Vagrant.configure("2") do |config|

    # etcd
    number_of_etcd = 1
    (0..number_of_etcd-1).each do |machine_id|
      config.vm.box = "centos/7"
      config.vm.define "etcd#{machine_id}" do |machine|
        machine.vm.hostname = "agent#{machine_id}"

        ip = machine_id
        machine.vm.hostname = "etcd#{machine_id}"
        machine.vm.network :private_network, ip: "192.168.56.#{ip}"

        machine.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
        end

        if machine_id == number_of_etcd-1
          machine.vm.provision :ansible do |ansible|
              ansible.limit = "all"
              ansible.playbook = "ansible/etcd/etcd-setup.yaml"
          end
        end
      end
    end

  # master
  config.vm.define "master" do |master|
    config.vm.box = "#{box_name}"
    master.vm.hostname = 'master'
    # master.vm.network :private_network, ip: "192.168.80.10", :netmask => "255.255.255.0"
    master.vm.network :private_network, ip: "192.168.56.10", :netmask => "255.255.255.0"
    master.vm.provider :virtualbox do |vbox|
        vbox.customize ["modifyvm", :id, "--memory", 1024]
        vbox.customize ["modifyvm", :id, "--cpus", 1]
    end

    master.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/k3s/master-setup.yaml"
    end
  end

  # (0..number_of_agents-1).each do |node_number|
  #   config.vm.box = "#{box_name}"
  #   config.vm.define "agent#{node_number}" do |agent|
  #     agent.vm.hostname = "agent#{node_number}"
  #     ip = node_number + 100
  #     # agent.vm.network :private_network, ip: "192.168.80.#{ip}", :netmask => "255.255.255.0"
  #     agent.vm.network :private_network, ip: "192.168.56.#{ip}", :netmask => "255.255.255.0"
  #     agent.vm.provider :virtualbox do |vbox|
  #         vbox.customize ["modifyvm", :id, "--memory", 1024]
  #         vbox.customize ["modifyvm", :id, "--cpus", 1]
  #     end
  #     agent.vm.provision "ansible" do |ansible|
  #       ansible.playbook = "ansible/k3s/agent-setup.yaml"
  #     end
  #   end
  # end


  # TODO: load balancer for multi-master setup

end
