Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end
   config.vm.synced_folder "./", "/etc/ansible"

   config.vm.provision "shell", privileged: true, inline: <<-SHELL
      apt-get update
      apt-get install software-properties-common -y
      apt-add-repository ppa:ansible/ansible
      apt-get update
      apt-get install nano -y
      apt-get install ansible -y
      export ANSIBLE_HOST_KEY_CHECKING=False
  	  cp /etc/ansible/keys/private.pem /etc/private.pem
	    chmod 400 /etc/private.pem
   SHELL
end
