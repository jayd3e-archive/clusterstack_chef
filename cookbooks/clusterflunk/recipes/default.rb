# Template for adding a new user
# user "random" do
#   comment "Random User"
#   uid 1000
#   gid "users"
#   home "/home/random"
#   shell "/bin/zsh"
#   password "pass"
# end

# Directory where Clusterflunk will be housed.
directory "/opt/webapp" do
  owner node['clusterflunk']['user']
  group "users"
  mode "0775"
  action :create
end

# Make virtualenv
execute "virtualenv" do
  user node['clusterflunk']['user']
  command "virtualenv --python=/opt/python-2.7.3/bin/python --no-site-packages /opt/webapp/env"
  creates "/opt/webapp/env"
  action :run
end

git "/home/#{node['clusterflunk']['user']}" do
    repository "git://github.com/clusterflunk/.dotfiles.git"
    destination "/home/#{node['clusterflunk']['user']}/.dotfiles"
    revision "master"
    action :sync
    user node['clusterflunk']['user']
end

link "/home/#{node['clusterflunk']['user']}/.profile" do
  to "/home/#{node['clusterflunk']['user']}/.dotfiles/.profile"
end

gem_package "sass" do
  action :install
end

# Hack to fix a Vagrant bug
execute "sudo_bug" do
  command "sed -i 's/%admin ALL=NOPASSWD:ALL/%admin ALL=\(ALL\) NOPASSWD:ALL/' /etc/sudoers"
  action :run
end
