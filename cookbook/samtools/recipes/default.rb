#
# Cookbook Name:: samtools
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

remote_file "/tmp/samtools.tar.bz2" do
  source "#{node[:samtools][:url]}"
  mode "0644"
end

execute "untar" do
  command "mkdir -p #{node[:samtools][:install_base]};
     bzip2 -d /tmp/samtools.tar.bz2
     tar -xvf /tmp/samtools.tar -C #{node[:samtools][:install_base]};
     ln -s #{node[:samtools][:install_base]}/samtools-* #{node[:samtools][:install_base]}/#{node[:samtools][:install_dir]};
     chmod a+rX #{node[:samtools][:install_base]}/#{node[:samtools][:install_dir]};
     cd #{node[:samtools][:install_base]}/#{node[:samtools][:install_dir]}; make"
  creates node[:samtools][:install_base] + "/" + node[:samtools][:install_dir]
  action :run
end

template "/etc/profile.d/samtools-path.sh" do
  source "samtools-path.sh.erb"
  mode 0755
  owner "root"
  group "root"
  variables(
	:samtools_install_dir => node[:samtools][:install_base] +"/" + node[:samtools][:install_dir]
  )
end

