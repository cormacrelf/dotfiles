# cormacrelf's dotfiles

    Forked way back from https://github.com/holman/dotfiles

Your dotfiles are how you personalize your system. These are mine.

## install

The clone location `$HOME/.dotfiles` is hardcoded quite a lot as `DOTFILES`, so remember the `.`

```sh
git clone https://github.com/cormacrelf/dotfiles.git $HOME/.dotfiles

cd $HOME/.dotfiles/ansible

# make sure this succeeds at the end
# it works on mac, ubuntu and debian proper
./install.sh

ansible-playbook main.yml --list-tags

# -K = ask for sudo pass, required for `--tags brew,apt` or all
ansible-playbook main.yml -K
```

## what's it got

heaps
