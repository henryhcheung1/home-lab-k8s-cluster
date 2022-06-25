MASTER_COUNT = 1
NODE_COUNT = 1
IMAGE = "ubuntu/bionic64"

Vagrant.configure("2") do |config|

    # frontend haproxy load balancer to k8s masters
    config.vm.define "front_lb" do |haproxy|
      haproxy.vm.box = IMAGE
      haproxy.vm.hostname = "haproxy"
      haproxy.vm.network  :private_network, ip: "10.0.0.30"   
      haproxy.vm.network :public_network, bridge: "wlo1", ip: "192.168.1.32"
      haproxy.vm.network "forwarded_port", guest: 6443, host: 6443
      haproxy.vm.provision "file", source: "scripts/haproxy/haproxy.cfg", destination: "/tmp/haproxy.cfg"
      haproxy.vm.provision "shell", privileged: true,  path: "scripts/haproxy/install_happroxy.sh"
    end
  
  # masters
  (1..MASTER_COUNT).each do |i|
    config.vm.define "kubemaster#{i}" do |kubemasters|
      kubemasters.vm.box = IMAGE
      kubemasters.vm.hostname = "kubemaster#{i}"
      kubemasters.vm.network  :private_network, ip: "10.0.0.#{i+10}"
      kubemasters.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
      kubemasters.vm.provision "file", source: "~/.ssh/id_rsa", destination: "/tmp/id_rsa"
      kubemasters.vm.provision "shell", privileged: true,  path: "scripts/master_install.sh"
    end
  end

  # workers
  (1..NODE_COUNT).each do |i|
    config.vm.define "kubenode#{i}" do |kubenodes|
      kubenodes.vm.box = IMAGE
      kubenodes.vm.hostname = "kubenode#{i}"
      kubenodes.vm.network  :private_network, ip: "10.0.0.#{i+20}"
      kubenodes.vm.network :public_network, bridge: "wlo1", ip: "192.168.1.#{i+20}"
      kubenodes.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
      kubenodes.vm.provision "file", source: "~/.ssh/id_rsa", destination: "/tmp/id_rsa"
      kubenodes.vm.provision "shell", privileged: true,  path: "scripts/node_install.sh"
    end
  end
end
