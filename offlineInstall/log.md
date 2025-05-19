
```
sudo apt-get update
sudo apt-get install dpkg-dev -y
sudo apt-get clean  

sudo apt-get install -d -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

mkdir ~/offline-repo
cp /var/cache/apt/archives/*.deb ~/offline-repo/

cd ~/offline-repo
dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
```


```
sudo mkdir -p /var/local/offline-repo
cp -r /media/usb/offline-repo/* /var/local/offline-repo/

echo "deb [trusted=yes] file:/var/local/offline-repo ./" | sudo tee -a /etc/apt/sources.list

sudo apt-get update
sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev -y

```

```

curl https://pyenv.run | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' 
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

source ~/.bashrc

pyenv --version

```

```
tar xzf pyenv-offline.tar.gz -C ~ --same-owner --warning=no-timestamp
```



```
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

source ~/.bashrc  

pyenv --version
```



```
cp python-3.11.4.tar.gz /root/.pyenv/versions/


cd /root/.pyenv/versions/

tar -xzf python-3.11.4.tar.gz

ls

pyenv rehash

pyenv versions

pyenv global 3.11.4

pyenv versions

python --version

pip list
```

