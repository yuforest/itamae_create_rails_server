execute 'set locale' do
  user 'root'
  command 'localectl set-locale LANG=ja_JP.utf8'
  not_if 'localectl status | grep ja_JP.utf8'
end