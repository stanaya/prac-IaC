# prac-IaC
## 環境構築
### virtualbox
`brew cask install virtualbox`

### vagrant
`brew cask install vagrant`

### ansible
#### pyhton 3.8
```
pyenv install 3.8.2
pyenv global 3.8.2
```
#### ansible
```
pip install --upgrade pip
pip install ansible
```
## マイルストーン
1. terraform勉強
2. ansible勉強
3. ansibleとterraformを用いて、aws上にhdfsを構築
4. ansibleとterraformを用いて、aws上にspark on kubernetes を構築
