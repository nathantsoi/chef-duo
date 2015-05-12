include_recipe 'git::default'

case node['platform']
when 'debian', 'ubuntu'
  %w/libtool openssl libssl-dev libpam0g-dev autoconf automake/.each do |pkg|
    apt_package pkg do
      action :install
    end
  end
when 'redhat', 'centos', 'fedora'
  # if this fails, run `sudo yum update` first
  %w/libtool openssl openssl-devel pam-devel autoconf automake/.each do |pkg|
    yum_package pkg do
      action :install
    end
  end
end

directory "#{Chef::Config[:file_cache_path]}/duo" do
  action :create
end

remote_file "#{Chef::Config[:file_cache_path]}/duo/#{node[:duo][:tarball_version]}" do
  source "#{node[:duo][:tarball_path]}#{node[:duo][:tarball_version]}"
  checksum '415cf02981f66ba9447df81e2fcf41e004220126640cc5f667720d46c431abf9'
  notifies :run, 'bash[compile_pam]'
end

bash 'compile_pam' do
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}/duo"
  code <<-EOH
  rm -rf src
  mkdir src
  tar xzf #{node[:duo][:tarball_version]} --directory src
  cd src/duo_unix-*
  ./bootstrap
  ./configure --with-pam --prefix=/usr
  make
  make install
  EOH
  not_if "readelf -a -W /lib64/security/pam_duo.so|grep SONAME|grep '0x000000000000000e'"
end

template '/etc/duo/pam_duo.conf' do
  source "#{node['platform']}/pam_duo.conf.erb"
  owner  'root'
  group  'root'
  mode   '0600'
end

case node['platform']
when 'ubuntu'
  template '/etc/pam.d/common-auth' do
    source "#{node['platform']}/common-auth.erb"
    owner  'root'
    group  'root'
    mode   '0755'
  end
when 'centos'
  template '/etc/pam.d/system-auth' do
    source "#{node['platform']}/system-auth.erb"
    owner  'root'
    group  'root'
    mode   '0755'
  end
end

template '/etc/pam.d/sshd' do
  source "#{node['platform']}/sshd.erb"
  owner  'root'
  group  'root'
  mode   '0755'
end


# configure ssh
include_recipe 'openssh::default'
