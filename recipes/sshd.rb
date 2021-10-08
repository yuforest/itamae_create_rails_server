directory '/home/rails/.ssh' do
  user 'root'
  mode '700'
  owner 'rails'
  action :create
end

remote_file '/home/rails/.ssh/authorized_keys' do
  user 'root'
  mode '600'
  owner 'rails'
  source '../remote_files/user/authorized_keys'
end

execute 'update sshd_config' do
  user 'root'
  command 'cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.org'
end


# ポート番号変更、ポートの変更後のポートを開放する必要あり
execute 'update sshd_config' do
  user 'root'
  command "sed -i \"s/^#Port 22/Port #{node["sshd"]["port"]}/g\" /etc/ssh/sshd_config"
end

execute 'prohibit root login' do
  user 'root'
  command "sed -i \"s/^#PermitRootLogin\ yes/PermitRootLogin\ no/g\" /etc/ssh/sshd_config"
end

service 'sshd' do
  user 'root'
  action :restart
end
