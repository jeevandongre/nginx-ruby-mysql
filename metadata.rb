name             'styletag'
maintainer       'jeevan dongre'
maintainer_email 'jeevan.dongre@styletag.com'
license          'All rights reserved'
description      'Install Mysql,creates user and databases'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


depends 'nginx'
depends 'rvm'
depends 'build-essential'
depends 'application'
depends 'application_ruby'
depends 'git'
depends 'database'
depends 'mysql'
depends 'apt'
depends 'unicorn-ng'