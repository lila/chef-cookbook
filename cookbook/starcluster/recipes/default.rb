#
# Cookbook Name:: starcluster
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/starcluster.tar.gz" do
  source "#{node[:starcluster][:url]}"
  mode "0644"
end

execute "untar" do
  command "mkdir -p #{node[:starcluster][:install_base]};
     tar -zxvf /tmp/starcluster.tar.gz -C #{node[:starcluster][:install_base]};
     ln -s #{node[:starcluster][:install_base]}/StarCluster-#{node[:starcluster][:version]} #{node[:starcluster][:install_base]}/#{node[:starcluster][:install_dir]};
     chmod a+rX #{node[:starcluster][:install_base]}/#{node[:starcluster][:install_dir]}"
  creates node[:starcluster][:install_base] + "/" + node[:starcluster][:install_dir]
  action :run
end

execute "setup" do
  command "cd /opt/starcluster; python distribute_setup.py; python setup.py install"
  creates node[:starcluster][:install_base] + "/" + node[:starcluster][:install_dir] + "/build"
  action :run
end

directory "/home/ec2-user/.starcluster" do
  action :create
  mode 0755
  owner "ec2-user"
  group "ec2-user"
end

template "/home/ec2-user/.starcluster/config" do
  source "config.erb"
  mode 0600
  owner "ec2-user"
  group "ec2-user"
  variables(
    :access_key_id => node[:starcluster][:access_key_id],
    :secret_access_key => node[:starcluster][:secret_access_key],
    :account_number => node[:starcluster][:account_number],
    :ensembl_volume => node[:starcluster][:ensembl_volumne],
    :cluster_keypair => node[:starcluster][:cluster_keypair]
  )
end