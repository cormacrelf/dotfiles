FROM ubuntu:bionic
RUN apt-get update && apt-get install -y git

WORKDIR app
COPY ansible/install.sh .
RUN ./install.sh

WORKDIR /root/.dotfiles/ansible
COPY ansible/requirements.yml .
RUN ansible-galaxy install -r requirements.yml

WORKDIR /root/.dotfiles
COPY . .
WORKDIR ansible
RUN ansible-playbook main.yml
