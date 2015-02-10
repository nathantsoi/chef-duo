name              'duo'
maintainer        'Nathan Tsoi'
maintainer_email  'nathan@vertile.com'
license           'Apache 2.0'
description       'Installs and configures duo unix'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md')).chomp
version           IO.read(File.join(File.dirname(__FILE__), 'VERSION')).chomp rescue '0.1.0'

recipe 'duo', 'Install duo security for unix '

%w{ ubuntu }.each do |os|
  supports os
end

depends 'git'
