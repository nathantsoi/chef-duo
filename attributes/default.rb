default['duo']['keys'] = {
  'integration' => nil,
  'secret' => nil,
  'host' => nil
}

default['duo']['git_repo'] = 'https://github.com/duosecurity/duo_unix.git'
default['duo']['git_rev'] = 'master'

# sshd, note that	key-words are case-insensitive and arguments are case-sensitive, however overrides are case sensitive
# the silly _p_a_m will yield _PAM
default['openssh']['server']['use_p_a_m'] = 'yes'
default['openssh']['server']['challenge_response_authentication'] = 'yes'
default['openssh']['server']['use_d_n_s'] = 'no'
default['openssh']['server']['pubkey_authentication'] = 'yes'
default['openssh']['server']['password_authentication'] = 'no'
default['openssh']['server']['authentication_methods'] = 'publickey,keyboard-interactive'
default['openssh']['server']['log_level'] = 'VERBOSE'
