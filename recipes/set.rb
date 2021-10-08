packages = [
  'package',
  'timezone',
  'selinux',
  'user',
  'sshd',
  'mysql',
  'nginx',
  'ruby',
  'rails',
].each do |pkg|
  include_recipe pkg
end
