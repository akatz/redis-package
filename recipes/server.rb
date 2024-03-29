#
# Cookbook Name:: redis
# Recipe:: server
#
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "redis" do
  package_name "redis-server"
  action :install
end

service "redis" do
  service_name "redis-server"
  supports :status => true, :restart => true
  action :enable
end

template "/etc/redis/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables({
    :vm => node['redis']['vm']
  })
  notifies :restart, resources(:service => "redis")
end

service "redis" do
  action :start
end
