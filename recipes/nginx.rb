remote_file '/etc/yum.repos.d/nginx.repo' do
  user 'root'
  source '../remote_files/nginx/nginx.repo'
end

package 'nginx' do
  user 'root'
  action :install
end

remote_file '/etc/nginx/nginx.conf' do
  user 'root'
  source '../remote_files/nginx/nginx.conf'
end

remote_file '/etc/nginx/conf.d/app.conf' do
  user 'root'
  source '../remote_files/nginx/app.conf'
end

service 'nginx' do
  user 'root'
  action [:enable, :start]
end