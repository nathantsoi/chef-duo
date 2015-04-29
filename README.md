in your Berksfile:

```
cookbook 'duo', git: 'git://github.com/nathantsoi/chef-duo.git'
```

include the default recipe to install with pam configuration

create a unix integration and set the following keys
 - found on your duo admin panel https://[admin-subdomain].duosecurity.com/integrations/[integration id]

here's an example from a role.rb file

```
override_attributes(
  'duo' => {
    'keys' => {
      'integration' => '',
      'secret' => '',
      'host' => ''
    }
  }
)
```

the following ssh config defaults are set:

```
default['openssh']['server']['use_pam'] = 'yes'
default['openssh']['server']['challenge_response_authentication'] = 'yes'
default['openssh']['server']['use_dns'] = 'no'
default['openssh']['server']['pubkey_authentication'] = 'yes'
default['openssh']['server']['password_authentication'] = 'no'
default['openssh']['server']['authentication_methods'] = 'publickey,keyboard-interactive'
default['openssh']['server']['log_level'] = 'VERBOSE'
```

open a root shell to make sure you still have access if things break

restart ssh

```
sudo service ssh restart
```

if it doesnt come back (no pid is shown with the start message), run ssh w/o upstart and look for error messages

```
/usr/sbin/sshd
```

logs are here

```
tail -f /var/log/auth.log
```
