Vagrant::Config.run do |config|
    config.vm.box = "ubuntu-1110-server-amd64"

    # Boost the RAM slightly and give it a reasonable name
    config.vm.customize [
        "modifyvm", :id, 
        "--memory", 1024,
        "--name", "Clusterpunk"
    ]

    config.vm.provision :chef_solo do |chef|
        chef.roles_path = "roles"
        chef.add_role("clusterflunk_dev")
    end
end
