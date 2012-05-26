# Template for adding a new user
# user "random" do
#   comment "Random User"
#   uid 1000
#   gid "users"
#   home "/home/random"
#   shell "/bin/zsh"
#   password "pass"
# end

# Create my user
user "jayd3e" do
  comment "Main Dev"
  uid 1001
  gid "users"
  home "/home/jayd3e"
  shell "/bin/bash"
  password "$1$GjoyjjTd$NE/SPlYhF3r0zt8NjgRQj."
end

# Directory where Clusterflunk will be housed.
directory "/opt/webapp" do
  owner "jayd3e"
  group "users"
  mode "0775"
  action :create
end

# Checkout code
git "/opt/webapp" do
  repository "git@github.com:Clusterflunk/Clusterflunk.git"
  reference "master"
  action :sync
end

# Make virtualenv
execute "virtualenv" do
  command "virtualenv --python=/opt/python-2.7.3/bin/python --no-site-packages env"
  creates "/opt/webapp/Clusterflunk/env"
  action :run
end