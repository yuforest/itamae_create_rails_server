# MySQLインストール
package 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm' do
  not_if 'rpm -q mysql-community-release-el6-5'
end

package 'mysql-community-server'
package 'mysql-community-devel'

# my.cnfのバックアップ
execute 'my.cnf backup' do
  command 'cp /etc/my.cnf /etc/my.cnf.org'
end

# MySQL起動、有効化
service 'mysqld' do
  action [:start, :enable]
end