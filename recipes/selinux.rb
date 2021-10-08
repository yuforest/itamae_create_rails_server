execute 'Stop SELinux' do
  user 'root'
  command 'setenforce 0'
  not_if "getenforce | grep 'Disabled'"
end

execute 'Disable SELinux' do
  user 'root'
  command "sed -i \"s/^SELINUX=enforcing/SELINUX=disabled/g\" /etc/selinux/config"
end