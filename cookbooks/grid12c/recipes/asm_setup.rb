#
# Cookbook Name:: grid12c
# Recipe:: asm_setup
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
# IF ASM is not already installed
#
if !node[:oracle][:grid][:asm_installed]
#
# Configure ASM driver
#
  bash "configure_asm" do
    code <<-EOH2
      /etc/init.d/oracleasm configure << EOF
grid
asmdba
y
y
EOF
      /usr/sbin/oracleasm init
      /etc/init.d/oracleasm scandisks
      /etc/init.d/oracleasm listdisks
    EOH2
  end
  node.default[:oracle][:grid][:asm_installed] = true
end
#
# Do we have to find and partition all devices
#
file_names=[]
if node[:oracle][:grid][:discover_disks]
  ruby_block "get unused sd devices" do
    block do
      node.set[:oracle][:grid][:sd_volumes] = {0 => "sdi", 1 => "sdh",2 => "sdg", 3=>"sdf"}
      diskcount=0
      files1 = Dir["/dev/sd?"]
      files1.each do |file_name|
        puts "\n"
#       if the device has not been partitioned (e.g. no sdb1) then we can use it as an asm volume 
        if Dir.glob("#{file_name}?").empty?
#         add to the sd volumes list
          puts "##1 Need to fdisk #{file_name} ## "
#          node.set[:oracle][:grid][:sd_volumes] = "#{file_name}"
#          node.set[:oracle][:grid][:sd_volumes] << [{diskcount => "#{file_name}"}]
#          node[:oracle][:grid][:sd_volumes] << [diskcount:"#{file_name}"]
#          node[:oracle][:grid][:sd_volumes] << ["#{file_name}"]
#          node[:oracle][:grid][:sd_volumes] << [diskcount:"#{file_name}"]
      node.set[:oracle][:grid][:sd_volumes] = {diskcount => "#{file_name}"}
#          node.set[:oracle][:grid][:sd_volumes].diskcount = "#{file_name}"
#          puts node[:oracle][:grid][:sd_volumes]
file_names.push("#{file_name}")
          puts "##2 Need to fdisk #{file_names} ## \n"
          diskcount=diskcount+1
        end
      end
      file_names.each do | name |
        puts "##5 Element was : #{name} \n"
        diskcount=diskcount+1
      end
    node.set[:oracle][:grid][:sd_volumes] = file_names
    end

    puts "##3 Need to fdisks #{file_names} ## \n"

#puts "#ARRAY# #{node[:oracle][:grid][:sd_volumes]} \n"
    file_names.each do | name |
      puts "##4 Element was : #{name} \n"
      diskcount=diskcount+1
    end
  end

  node[:oracle][:grid][:sd_volumes].each do | dn |
    puts "### now fdisk #{dn} ### \n"
#    bash "create_partitions" do
#      code <<-EOH3
#      fdisk #{dn} << EOF
#n
#p
#1
#
#
#w
#EOF
#      EOH3
#    end
  end
end

