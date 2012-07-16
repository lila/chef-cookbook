#
# Cookbook Name:: ec2-commandline-tools
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/ec2-api-tools.zip" do
  source "#{node[:ec2_commandline_tools][:url]}"
  mode "0644"
end

remote_file "/tmp/sns.zip" do
  source "#{node[:ec2_commandline_tools][:url_sns]}"
  mode "0644"
end

execute "zip" do
  command "mkdir -p #{node[:ec2_commandline_tools][:install_base]};
     unzip /tmp/ec2-api-tools.zip -d #{node[:ec2_commandline_tools][:install_base]};
     ln -s #{node[:ec2_commandline_tools][:install_base]}/ec2-api-tools-* #{node[:ec2_commandline_tools][:install_base]}/#{node[:ec2_commandline_tools][:install_dir]};
     chmod a+rX #{node[:ec2_commandline_tools][:install_base]}/#{node[:ec2_commandline_tools][:install_dir]}"
  creates node[:ec2_commandline_tools][:install_base] + "/" + node[:ec2_commandline_tools][:install_dir]
  action :run
end

execute "snszip" do
  command "mkdir -p #{node[:ec2_commandline_tools][:install_base]};
     unzip /tmp/sns.zip -d #{node[:ec2_commandline_tools][:install_base]};
     ln -s #{node[:ec2_commandline_tools][:install_base]}/SimpleNotificationServiceCli* #{node[:ec2_commandline_tools][:install_base]}/#{node[:ec2_commandline_tools][:install_dir_sns]};
     chmod a+rX #{node[:ec2_commandline_tools][:install_base]}/#{node[:ec2_commandline_tools][:install_dir_sns]}"
  creates node[:ec2_commandline_tools][:install_base] + "/" + node[:ec2_commandline_tools][:install_dir_sns]
  action :run
end

template "/etc/profile.d/ec2-commandline-tools-path.sh" do
  source "ec2-commandline-tools-path.sh.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:aws_install_base => node[:ec2_commandline_tools][:install_base],
	:ec2_install_dir => node[:ec2_commandline_tools][:install_base] +"/" + node[:ec2_commandline_tools][:install_dir],
	:sns_install_dir => node[:ec2_commandline_tools][:install_base] +"/" + node[:ec2_commandline_tools][:install_dir_sns],
	:aws_access_key_id => node[:ec2_commandline_tools][:access_key_id],
	:aws_secret_key_id => node[:ec2_commandline_tools][:secret_access_key]
  )
end

template "/opt/aws/sns/credentials.cnf" do
  source "credentials.cnf.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:aws_install_base => node[:ec2_commandline_tools][:install_base],
	:ec2_install_dir => node[:ec2_commandline_tools][:install_base] +"/" + node[:ec2_commandline_tools][:install_dir],
	:sns_install_dir => node[:ec2_commandline_tools][:install_base] +"/" + node[:ec2_commandline_tools][:install_dir_sns],
	:aws_access_key_id => node[:ec2_commandline_tools][:access_key_id],
	:aws_secret_key_id => node[:ec2_commandline_tools][:secret_access_key]
  )
end
