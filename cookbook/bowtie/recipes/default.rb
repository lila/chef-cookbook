#
# Cookbook Name:: bowtie
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/bowtie.zip" do
  source "#{node[:bowtie][:url]}"
  mode "0644"
end

execute "zip" do
  command "mkdir -p #{node[:bowtie][:install_base]};
     unzip /tmp/bowtie.zip -d #{node[:bowtie][:install_base]};
     ln -s #{node[:bowtie][:install_base]}/bowtie-* #{node[:bowtie][:install_base]}/#{node[:bowtie][:install_dir]};
     chmod a+rX #{node[:bowtie][:install_base]}/#{node[:bowtie][:install_dir]}"
  creates node[:bowtie][:install_base] + "/" + node[:bowtie][:install_dir]
  action :run
end

template "/etc/profile.d/bowtie-path.sh" do
  source "bowtie-path.sh.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:bowtie_install_dir => node[:bowtie][:install_base] +"/" + node[:bowtie][:install_dir]
  )
end

