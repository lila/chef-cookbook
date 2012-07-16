#
# Cookbook Name:: ec2-commandline-tools
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/cloudwatch.zip" do
  source "#{node[:cloudwatch_cli][:url]}"
  mode "0644"
end

execute "zip" do
  command "mkdir -p #{node[:cloudwatch_cli][:install_base]};
     unzip /tmp/cloudwatch.zip -d #{node[:cloudwatch_cli][:install_base]};
     ln -s #{node[:cloudwatch_cli][:install_base]}/CloudWatch-* #{node[:cloudwatch_cli][:install_base]}/#{node[:cloudwatch_cli][:install_dir]};
     chmod a+rX #{node[:cloudwatch_cli][:install_base]}/#{node[:cloudwatch_cli][:install_dir]}"
  creates node[:cloudwatch_cli][:install_base] + "/" + node[:cloudwatch_cli][:install_dir]
  action :run
end

template "/etc/profile.d/cloudwatch-path.sh" do
  source "cloudwatch-path.sh.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:cw_install_dir => node[:cloudwatch_cli][:install_base] +"/" + node[:cloudwatch_cli][:install_dir],
	:aws_access_key_id => node[:cloudwatch_cli][:access_key_id],
	:aws_secret_key_id => node[:cloudwatch_cli][:secret_access_key]
  )
end

template "/opt/aws/cw/credentials.cnf" do
  source "credentials.cnf.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:cw_install_base => node[:cloudwatch_cli][:install_base],
	:ec2_install_dir => node[:cloudwatch_cli][:install_base] +"/" + node[:cloudwatch_cli][:install_dir],
	:sns_install_dir => node[:cloudwatch_cli][:install_base] +"/" + node[:cloudwatch_cli][:install_dir_sns],
	:aws_access_key_id => node[:cloudwatch_cli][:access_key_id],
	:aws_secret_key_id => node[:cloudwatch_cli][:secret_access_key]
  )
end
