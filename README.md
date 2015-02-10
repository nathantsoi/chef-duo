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

ensure the following are set in /etc/ssh/sshd_config

```
UsePAM yes
ChallengeResponseAuthentication yes
UseDNS no
Public Key Authentication
PubkeyAuthentication yes
PasswordAuthentication no
AuthenticationMethods publickey,keyboard-interactive
# for debugging and better auditing
LogLevel VERBOSE
```

open a root shell to make sure you still have access if things break

restart ssh

```
sudo service sshd restart
```

if it doesnt come back (no pid is shown with the start message), run ssh w/o upstart and look for error messages

```
/usr/sbin/sshd
```

logs are here

```
tail -f /var/log/auth.log
```
