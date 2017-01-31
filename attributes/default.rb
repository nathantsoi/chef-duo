default['duo']['keys'] = {
  'integration' => nil,
  'secret' => nil,
  'host' => nil
}

default['duo']['tarball_path'] = 'https://dl.duosecurity.com/'
default['duo']['tarball_version'] = 'duo_unix-1.9.14.tar.gz'

default['duo']['git_repo'] = 'https://github.com/duosecurity/duo_unix.git'
default['duo']['git_rev'] = 'master'

default['duo']['pushinfo'] = 'yes'
default['duo']['autopush'] = 'yes'

# sshd, note that	key-words are case-insensitive and arguments are case-sensitive, however overrides are case sensitive
# the silly _p_a_m will yield _PAM
default['openssh']['server']['use_p_a_m'] = 'yes'
default['openssh']['server']['challenge_response_authentication'] = 'yes'
default['openssh']['server']['use_d_n_s'] = 'no'
default['openssh']['server']['pubkey_authentication'] = 'yes'
default['openssh']['server']['password_authentication'] = 'no'
case node['platform']
when 'ubuntu'
default['openssh']['server']['authentication_methods'] = 'publickey,keyboard-interactive'
when 'centos'
default['openssh']['server']['required_authentications2'] = 'publickey,keyboard-interactive'
end
default['openssh']['server']['log_level'] = 'VERBOSE'
