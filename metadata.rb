name 'satellite6'
maintainer       'Rocky Olsen (rolsen)'
maintainer_email 'rolsen@secureworks.com'
license          'Apache License, Version 2.0'
description 'Installs/Configures satellite6'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.4'
# assume we support redhat, other OSes include: ubuntu debian redhat centos fedora oracle suse freebsd openbsd mac_os_x mac_os_x_server windows aix
%w{ redhat }.each do |os|
  supports os
end

depends 'selinux'
depends 'ntp'
depends 'iptables'
depends 'java'
depends 'chef-sugar'
depends 'openssl'
