execute 'set timezone' do
  user 'root'
  command <<-EOL
    cp -p /usr/share/zoneinfo/Japan /etc/localtime
    echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
    echo 'UTC=false' >> /etc/sysconfig/clock
  EOL
end

package 'ntp'

execute 'yum -y install ntpdate' do
  user 'root'
end

execute 'set datetime' do
  user 'root'
  command 'ntpdate ntp.nict.jp'
end