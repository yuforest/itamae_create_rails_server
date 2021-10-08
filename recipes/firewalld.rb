package 'firewalld'

service 'firewalld' do
  action [:start, :enable]
end

# firewalldのServiceの設定
template '/etc/firewalld/services/ssh-secure.xml' do
  source 'remote_files/firewalld/ssh-secure.xml.erb'
  variables(port: node['sshd']['port'])
end

execute 'firewalld add ssh-secure service' do
  command 'firewall-cmd --add-service=ssh-secure --zone=public --permanent'
end

execute 'firewalld add http service' do
  command 'firewall-cmd --add-service=http --zone=public --permanent'
end

execute 'firewalld add https service' do
  command 'firewall-cmd --add-service=https --zone=public --permanent'
end

execute 'firewalld remove ssh service' do
  command 'firewall-cmd --remove-service=ssh --zone=public --permanent'
end

execute 'firewalld reload' do
  command 'firewall-cmd --reload'
end

service 'firewalld' do
  action :restart
end
