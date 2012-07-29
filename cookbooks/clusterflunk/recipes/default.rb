# Template for adding a new user
# user "random" do
#   comment "Random User"
#   uid 1000
#   gid "users"
#   home "/home/random"
#   shell "/bin/zsh"
#   password "pass"
# end

# Directory where clusterflunk will be housed.
directory "/opt/webapp" do
  owner node['clusterflunk']['user']
  group "users"
  mode "0775"
  action :create
end

# Make virtualenv for clusterflunk
execute "virtualenv" do
  user node['clusterflunk']['user']
  command "virtualenv --python=/opt/python-2.7.3/bin/python --no-site-packages /opt/webapp/clusterflunk"
  action :run
end

# Clone .dotefiles, so we can get the vagrant user's profile and such
git "/home/#{node['clusterflunk']['user']}" do
  repository "git://github.com/clusterflunk/.dotfiles.git"
  destination "/home/#{node['clusterflunk']['user']}/.dotfiles"
  revision "master"
  action :sync
  user node['clusterflunk']['user']
end

# Symlink the profile
link "/home/#{node['clusterflunk']['user']}/.profile" do
  to "/home/#{node['clusterflunk']['user']}/.dotfiles/.profile"
end

# Install sass
gem_package "sass" do
  action :install
end

# Hack to fix a Vagrant bug
execute "sudo_bug" do
  command "sed -i 's/%admin ALL=NOPASSWD:ALL/%admin ALL=\(ALL\) NOPASSWD:ALL/' /etc/sudoers"
  action :run
end

# Directory where cheeseprism will be housed.
directory "/opt/cheeseprism" do
  owner node['clusterflunk']['user']
  group "users"
  mode "0775"
  action :create
end

# Clone cheeseprism
git "/opt/cheeseprism" do
  repository "https://github.com/SurveyMonkey/CheesePrism.git"
  destination "/opt/cheeseprism/src"
  revision "master"
  action :sync
  user node['clusterflunk']['user']
end

# Make virtualenv for cheeseprism
execute "virtualenv" do
  user node['clusterflunk']['user']
  command "virtualenv --python=/opt/python-2.7.3/bin/python --no-site-packages /opt/cheeseprism"
  action :run
end

# Install cheeseprism dependencies
execute "python" do
  user 'root'
  command "/opt/cheeseprism/bin/python /opt/cheeseprism/src/setup.py install"
  action :run
end
