# `git` stuff done

```bash
# man up your mac
xcode-select --install

# fix ssh key
ssh-keygen -t ed25519 -C "<your_email@example.com>"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# (then paste the key into github ssh settings (https://github.com/settings/keys)

# clone repo
git clone git@github.com:cekrem/dotfiles.git
cd dotfiles

# start setup!
./mac-setup.sh

```
