%w(
  package
  timezone
  selinux
  sshd
  mysql
  nginx
  ruby
  rails
).each do |pkg|
  include_recipe pkg
end