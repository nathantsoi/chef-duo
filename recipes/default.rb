include_recipe 'git::default'

%w/libtool openssl libssl-dev libpam0g-dev/.each do |pkg|
  apt_package pkg do
    action :install
  end
end

git "#{Chef::Config[:file_cache_path]}/duo" do
  repository node[:duo][:git_repo]
  revision node[:duo][:git_rev]
  action :sync
  notifies :run, 'bash[compile_pam]'
end

bash 'compile_pam' do
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}/duo"
  code <<-EOH
  ./bootstrap
  ./configure --with-pam --prefix=/usr
  make
  make install
  EOH
end

template '/etc/duo/pam_duo.conf' do
  source "#{node['platform']}/pam_duo.conf.erb"
  owner  'root'
  group  'root'
  mode   '0700'
end

template '/etc/pam.d/common-auth' do
  source "#{node['platform']}/common-auth.erb"
  owner  'root'
  group  'root'
  mode   '0755'
end

template '/etc/pam.d/sshd' do
  source "#{node['platform']}/sshd.erb"
  owner  'root'
  group  'root'
  mode   '0755'
end
