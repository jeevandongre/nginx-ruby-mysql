#
# Cookbook Name:: styletag
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

#Includes mysql database recipe
 
 include_recipe "application"
 include_recipe "runit"
 include_recipe "nginx"
 include_recipe "apt"
 include_recipe "git"
 include_recipe "build-essential"
 include_recipe "mysql::server"
 include_recipe "rvm::system"

 mysql_chef_gem "default" do
  action :install
 end 

execute "update" do
  command "apt-get update" 
end

service "nginx" do
  action :stop
end

apt_package "bundler" do
  action :install
end

Directory "/root/.ssh" do
   action :create
   mode 0700
end

File "/root/.ssh/config" do
   action :create
   content "Host *\nStrictHostKeyChecking no"
   mode 0600
end

application 'name' do
   path  'path to deploy'
   repository 'path to repo'
   revision   'branch'
       
   rails do
     #migrate true
     bundler true
     precompile_assets true
  end
end

mysql_database 'database name' do
  connection(
    :host     => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
  )
  action :create
end


unicorn_config "/path/to/unicorn/config/unicorn.rb" do
  listen({"/tmp/unicorn.sock" => nil })
  working_directory "/path/to/working_directory/current/"
  worker_timeout 60
  worker_processes 1 
  preload_app true
  stderr_path = "/path/to/log/stderr.log"
  stdout_path = "/path/to/log/stdout.log"
end



template "database.yml" do 
  path "/path/to//config/database.yml"
  source "database.yml"
  owner "vagrant"
  mode "0644"
end


execute "bundle exec unicorn -D -c config/unicorn.rb -E production" do 
cwd "/path/to/application/path/current"

end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.config"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  notifies :restart, "service[nginx]", :immediately
end
