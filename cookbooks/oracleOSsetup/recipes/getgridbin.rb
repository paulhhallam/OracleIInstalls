#
# Cookbook Name:: oracle
# Recipe:: getgridbin
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
## Get and unzip the Oracle Grid binaries.
#

# We need unzip to expand the install files later on.
yum_package 'unzip'

#
# We have wget.sh in ~/Downloads which will get the 12.1.0.2 grid software from oracle BUT
# we don't really want to include that at the moment as it has passwords encoded
# For now we'll assume the software is local
# 
#phh# node[:oracle][:grid][:install_files].each do |zip_file|
#phh#   execute "fetch_oracle_media_#{zip_file}" do
#phh#     command "cp /u01/V* ."
#phh#     user "grid"
#phh#     group 'oinstall'
#phh#     cwd node[:oracle][:grid][:install_dir]
#phh#   end
#phh# 
#phh#   execute "unzip_oracle_media_#{zip_file}" do
#phh#     command "unzip -o #{File.basename(zip_file)}"
#phh#     user "grid"
#phh#     group 'oinstall'
#phh#     cwd node[:oracle][:grid][:install_dir]
#phh#   end
#phh# end
#phh# 
#phh# file "#{node[:oracle][:grid][:install_dir]}/V*" do 
#phh#   action :delete
#phh# end
#phh# 
#phh# bash 'clean_installer' do
#phh#     cwd "#{node[:oracle][:grid][:install_dir]}"
#phh#     code "rm -f V*"
#phh#   end

#
# Reboot the node 
#
#reboot 'now' do
#  action :request_reboot
#  reason 'Cannot continue Chef run without a reboot.'
#  delay_mins 1
#end
 
