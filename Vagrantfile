# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

RUN_LIST = %w(recipe[ejbca])
CHEF_ATTRIBUTES = {
    cap: {
        agent: {
            release: 'develop'
        }
    }
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'boxcutter/ubuntu1404-desktop'

  config.vm.provider 'parallels' do |prl|
    prl.linked_clone = true
    prl.check_guest_tools = false
    prl.memory = 3072
    prl.cpus = 2
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = true

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ['modifyvm', :id, '--memory', '3072']
  end

  config.vm.provision 'chef_solo' do |chef|
    chef.run_list = RUN_LIST
    chef.json = CHEF_ATTRIBUTES
  end
end
