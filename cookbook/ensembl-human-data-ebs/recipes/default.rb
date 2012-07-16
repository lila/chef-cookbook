#
# Cookbook Name:: ensembl-human-data-ebs
# Recipe:: default
#
# Copyright 2012, Amazon.com
#

directory "#{node[:ensembl_human_data_ebs][:mount_point]}" do
  action :create
  mode 0755
  owner "root"
  group "root"
end


execute "mount" do
  command "mount #{node[:ensembl_human_data_ebs][:device]} #{node[:ensembl_human_data_ebs][:mount_point]}"
  creates node[:ensembl_human_data_ebs][:mount_point] + "/mysql"
  action :run
end

