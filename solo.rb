# chef-solo -c /etc/chef/solo.rb -j /etc/chef/dna.json
file_cache_path  "/opt/clusterstack"
cookbook_path    "/opt/clusterstack/cookbooks"
log_level        :info
log_location     STDOUT
ssl_verify_mode  :verify_none
role_path        "/opt/clusterstack/roles"
