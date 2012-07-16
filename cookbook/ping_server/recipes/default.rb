#
# Cookbook Name:: ec2-commandline-tools
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/ping_server.tgz" do
  source "#{node[:ping][:url]}"
  mode "0644"
end

execute "zip" do
  command "mkdir -p #{node[:ping][:install_base]};
     cd #{node[:ping][:install_base]}; tar -xvf /tmp/ping_server.tgz;
     ln -s #{node[:play][:install_base]}/ping_se* #{node[:ping][:install_base]}/#{node[:ping][:install_dir]};
     chmod a+rX #{node[:ping][:install_base]}/#{node[:ping][:install_dir]}"
  creates node[:ping][:install_base] + "/" + node[:ping][:install_dir]
  action :run
end


template "/etc/init.d/ping" do
  source "ping.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:ping_install_dir => node[:ping][:install_base] +"/" + node[:ping][:install_dir],
	:ping_public_ip => node[:ping][:endpointip],
	:sns_topic => node[:ping][:snsuri]
  )
end

template "/opt/ping/conf/application.conf" do
  source "application.conf.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
        :ping_notification_uri => node[:ping][:snsprogressuri]
  )
end

# typically this will run /etc/init.d/example_service start
service "ping" do
  action :start
end
