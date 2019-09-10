VAGRANT_COMMAND = ARGV[0]
milestone = "cbc"
update_version = "232"
build_number = "b04"

Vagrant.configure("2") do |config|
  if VAGRANT_COMMAND == "ssh"
    config.ssh.username = 'vagrant'
  end

  config.vm.define "build1" do |build1|
    build1.vm.provision "shell", path: "./common/build-setup.sh", args: "#{milestone} #{update_version} #{build_number}"
    build1.vm.synced_folder "./common/", "/common"
    build1.vm.box = "centos/7"
 
    build1.vm.network "private_network", ip: "10.10.10.90"
    build1.vm.hostname = "build1" 
 
    build1.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "2048"
    end

  end
end
