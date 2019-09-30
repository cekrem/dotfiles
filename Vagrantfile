Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"
  config.vm.provider "virtualbox" do |v|
    v.memory = 12288
    v.cpus = 4
    v.customize ["modifyvm", :id, "--ioapic", "on"] # Allow multicore
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"] # Use host DNS
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 7000, host: 7000

  config.vm.provision "shell", inline: "sudo pacman -S --noconfirm git"
  config.vm.provision "shell", inline: "git clone https://github.com/cekrem/dotfiles.git", privileged: false
  config.vm.provision "shell", inline: "~/dotfiles/arch-setup.sh", privileged: false
  config.vm.provision "shell", inline: "~/dotfiles/setup-sub-packages.sh", privileged: false
  config.vm.provision "shell", inline: "mv ~/dotfiles/.git ~/.git; rm -rf ~/dotfiles; git stash", privileged: false
  config.vm.provision "shell", inline: "git remote set-url origin git@github.com:cekrem/dotfiles.git", privileged: false
  config.vm.provision "file", source: "~/.private.env", destination: "~/"
  config.vm.provision "file", source: "~/.ssh", destination: "~/"
end
