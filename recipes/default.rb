#
# Copyright (c) 2012-2014, Chef Software, Inc. <legal@getchef.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

begin
  env = data_bag_item('chefdown', node.chef_environment)
  chefdown = if (env['chefdown'] == 'all')
    "Environment's chefdown data bag is set to `all`"
  elsif (is_daemonized? and env['chefdown'] == 'daemonized')
    "Environment's chefdown is set to `daemonized`"
  else
    false
  end
rescue
  Chef::Log.warn("Could not find the '#{node.chef_environment}' item in the 'chefdown' data bag")
  raise "Could not load chefdown data bag" if node['chefdown']['fail_on_data_bag']
ensure
  chefdown_tags = node['tags'].select{ |x| x.start_with? 'chefdown_' } || []
  unless chefdown_tags.empty?
    chefdown = "Node is tagged #{ chefdown_tags.join ', ' }"
  end
  if chefdown
    Chef::Log.fatal "Aborting CCR run due to chefdown: #{chefdown}"
    raise "Aborting CCR run due to chefdown: #{chefdown}"
  end
end
