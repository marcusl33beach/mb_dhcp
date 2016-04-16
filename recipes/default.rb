# Cookbook Name:: mb_dhcp
# Recipe:: default

# Install needed packages
package 'dhcp' do
  action :install
end

#start dhcpd
service 'dhcpd' do
  supports :status => true
  action [ :enable, :start ]
end

# Write out templates
template '/etc/dhcp/dhcpd.conf' do
  source 'dhcpd.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
  variables({
    :domanename => node['dhcp']['domain_name'],
    :domainnameservers => node['dhcp']['domain_name_servers'],
    :leasetime => node['dhcp']['lease_time'],
    :maxlease => node['dhcp']['max_lease'],
    :subnet => node['dhcp']['subnet'],
    :netmask => node['dhcp']['netmask'],
    :range => node['dhcp']['range'],
    :broadcast => node['dhcp']['broadcast'],
    :routers => node['dhcp']['routers']
  })
  notifies :restart, 'service[dhcpd]'
end
