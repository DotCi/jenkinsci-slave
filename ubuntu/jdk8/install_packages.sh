#!/bin/bash -e
# description: /job/<org>/job/<repo>/configure to build type as com.groupon.jenkins.buildtype.install_packages.InstallPackagesBuild
# instead of combo box drop down setting as com.groupon.jenkins.buildtype.dockercompose.DockerComposeBuild
# will result in DotCi executing install_packages using this script based on .ci.yml definition of packages per
# http://groupon.github.io/DotCi/usage/ci_yml/build_types/InstallPackages.html#environment-section

[ -z $@ ] && exit 0

dotciMode=''
test -e /etc/redhat-release && dotciMode='yum'
test -e /etc/debian_version && dotciMode='apt-get'
case $dotciMode in
  'yum' )
    time sudo yum -y install "$@"
    ;;
  'apt-get' )
    time sudo apt-get -y install "$@"
    ;;
  *)
    echo "$0 has not been configured to handle the OS for `hostname -f`"
    exit 1
    ;;
esac
