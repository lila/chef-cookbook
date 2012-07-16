#
# Cookbook Name:: ec2-commandline-tools
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/play.zip" do
  source "#{node[:play][:url]}"
  mode "0644"
end

execute "zip" do
  command "mkdir -p #{node[:play][:install_base]};
     unzip /tmp/play.zip -d #{node[:play][:install_base]};
     ln -s #{node[:play][:install_base]}/play-* #{node[:play][:install_base]}/#{node[:play][:install_dir]};
     chmod a+rX #{node[:play][:install_base]}/#{node[:play][:install_dir]}"
  creates node[:play][:install_base] + "/" + node[:play][:install_dir]
  action :run
end

template "/etc/profile.d/play-path.sh" do
  source "play-path.sh.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:play_install_dir => node[:play][:install_base] +"/" + node[:play][:install_dir]
  )
end

