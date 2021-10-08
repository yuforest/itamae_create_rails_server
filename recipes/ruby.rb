# Amazon linuxではこのコマンドの実行が必要, centOSではコメントアウト
execute 'amazon-linux-extras install epel' do
  user 'root'
end

package 'epel-release'
package 'gcc'
package 'gcc-c++'
package 'glibc-headers'
package 'openssl-devel'
package 'libyaml-devel'
package 'readline'
package 'readline-devel'
package 'zlib'
package 'zlib-devel'
package 'git'
package 'bzip2'

RBENV_DIR = '/usr/local/rbenv'
RBENV_SCRIPT = '/etc/profile.d/rbenv.sh'

git RBENV_DIR do
  repository 'git://github.com/sstephenson/rbenv.git'
end

directory "#{RBENV_DIR}/shims" do
  action :create
end

directory "#{RBENV_DIR}/versions" do
  action :create
end

remote_file RBENV_SCRIPT do
  source '../remote_files/ruby/rbenv.sh'
end

execute "set owner and mode for #{RBENV_SCRIPT}" do
  command "chgrp root: #{RBENV_SCRIPT}; chmod 644 #{RBENV_SCRIPT}"
end

directory "#{RBENV_DIR}/plugins" do
  action :create
end

git "#{RBENV_DIR}/plugins/ruby-build" do
  repository 'git://github.com/sstephenson/ruby-build.git'
end

node['rbenv']['versions'].each do |version|
  execute "install ruby #{version}" do
    command "source #{RBENV_SCRIPT}; export RUBY_CONFIGURE_OPTS=--disable-install-doc; rbenv install #{version}"
    not_if "source #{RBENV_SCRIPT}; rbenv versions | grep #{version}"
  end
end

execute "set global ruby #{node['rbenv']['global']}" do
  command "source #{RBENV_SCRIPT}; rbenv global #{node['rbenv']['global']}; rbenv rehash"
  not_if "source #{RBENV_SCRIPT}; rbenv global | grep #{node['rbenv']['global']}"
end

node['rbenv']['gems'].each do |gem|
  execute "gem install #{gem['name']}" do
    command "source #{RBENV_SCRIPT}; gem install #{gem['name']} #{gem['option']}; rbenv rehash"
    not_if "source #{RBENV_SCRIPT}; gem list | grep #{gem['name']}"
  end
end
