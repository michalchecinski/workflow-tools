############
#  System  #
############

# Install snap
apt install -y snapd

# Setup root user profile
apt install -y vim #as root, for root.
echo "export EDITOR=vim" >> /root/.profile
echo "alias nvim=vim"

# Install docker?

# Setup local network hostnames
echo "=====Homelab====="
echo "192.168.0.251 ks8-node1" >> /etc/hosts
echo "192.168.0.252 ks8-node2" >> /etc/hosts
echo "192.168.0.253 ks8-node3" >> /etc/hosts
echo "192.168.0.109 nas" >> /etc/hosts
echo "================="


########################
#  Personal Workspace  #
########################
sudo apt update

sudo apt install -y \
  tmux \
  htop \
  jq \
  python3-pip

sudo snap install k9s

# Install personal configs
git clone https://github.com/joseph-flinn/workflow-tools.git ~/workflow-tools
sh ~/workflow-tools/dotfiles/install_dotfiles.sh ubuntu

# Install/Setup NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir ~/.config/nvim
cp ~/workflow-tools/dotfiles/configs/init.vim ~/.config/nvim

# Install Pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# Install Ansible
python3 -m pip install ansible

# k8s - tools
mkdir ~/.kube

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm ./kubectl

kubectx_version=$(\
  curl --silent "https://api.github.com/repos/ahmetb/kubectx/releases/latest" | \
  jq -r .tag_name
)
curl -sSL https://github.com/ahmetb/kubectx/releases/download/$kubectx_version/kubectx --output ~/.local/bin/kubectx
chmod +x ~/.local/bin/kubectx
curl -sSL https://github.com/ahmetb/kubectx/releases/download/$kubectx_version/kubens --output ~/.local/bin/kubens
chmod +x ~/.local/bin/kubens

k9s_version=$(\
  curl --silent "https://api.github.com/repos/ahmetb/kubectx/releases/latest" | \
  jq -r .tag_name
)
curl -LO https://github.com/derailed/k9s/releases/download/$k9s_version/k9s_Linux_x86_64.tar.gz

