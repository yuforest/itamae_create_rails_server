user 'rails' do
  action :create
end

execute 'edit sudoers' do
  user 'root'
  command "echo 'rails ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rails"
end