#!/bin/bash
# install.sh

DOTFILES=$HOME/.dotfiles


os_release() {
  test -s /etc/os-release && ( . /etc/os-release && eval "echo \$$1" )
}

symlink_hosts() {
  echo "-----------------"
  echo "installed ansible. testing:"
  ansible localhost -m ping
  exit 0
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  if hash brew 2>/dev/null; then
    echo "ok: brew installed already"
  else 
    echo "~~~ now installing homebrew ~~~"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew install ansible
  symlink_hosts
fi

# https://docs.ansible.com/ansible/2.5/installation_guide/intro_installation.html

if test -s /etc/os-release; then
  if [[ $(os_release ID) == "ubuntu" ]]; then
    echo 'ubuntu detected'
    echo '---------------'
    apt-get update -y
    if [[ $(os_release UBUNTU_CODENAME) == "trusty" ]]; then
      apt-get install -y python-software-properties-common
    else
      apt-get install -y software-properties-common
    fi
    apt-add-repository -y ppa:ansible/ansible
    apt-get update
    apt-get install -y ansible
    symlink_hosts
  fi

  if [[ $(os_release ID) == "debian" ]]; then
    echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
    echo 'debian detected'
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    apt-get update
    apt-get install -y ansible
    symlink_hosts
  fi

fi

