# 用件
- hadoop 3.3.0
- vagrant box:centos 7.2
- JDK:

# 手順
## vagrant box add
```
vagrant box add centos7.2 https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.2/vagrant-centos-7.2.box
vagrant box list
```
- http://www.vagrantbox.es/

## vm起動
```
mkdir -p centosVM
cd centosVM
vagrant init centos7.2
```

- `vagrant init centos7.2`実行後Vagrantfileが生成される。
- Vagrantfileを編集

>#config.vm.network "forwarded_port", guest: 80, host: 80

上記のコメントアウトを外し、

  >config.vm.network "forwarded_port", guest: 50070, host: 50070

をに変更。
これはvagrantサーバ上でHDFSを起動させた後、
ブラウザから管理画面をみるための設定です。
こうしておくことで、Macのブラウザでlocalhost:50070と打つことで、
vagrant上の50070ポートのプロセスにアクセスすることが可能。
vagrantのサーバにプライベートIPをつけることも可能。
```
vagrant up
```
でVMが立ち上がる。

## sshでhadoopとその依存ファイルをインストール
### sshログイン
sshでVMログイン。デフォルトでは
```
ssh vagrant@127.0.0.1
```
でログインする。パスワードは`vagrant`

### wgetのインストール
```
sudo su -
yum install wget
```
### JDKのインストール
```
yum install java-1.8.0-openjdk
yum install java-1.8.0-openjdk-devel
```

### 依存ライブラリインストール(hadoop公式)
```
yum install pdsh
```

### hadoop インストール
```
 wget https://ftp.yz.yamagata-u.ac.jp/pub/network/apache/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
 tar -zxvf hadoop-3.3.0.tar.gz
 mv hadoop-3.3.0 /usr/
```

### 環境変数設定
$JAVA_HOMEは
```
rpm -ql  java-1.8.0-openjdk
```
で調べて。
.bash_profileを編集
```
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64/jre
export HADOOP_HOME=/usr/hadoop-3.3.0
PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$PATH
```

変更反映
```
exec $SHELL -l
```

# 参考
- https://qiita.com/hmuronaka/items/b96aeb8179a4c74a4f9e
- https://qiita.com/maitake9116/items/ed7197043cdbe1971a14
- https://qiita.com/taketarouex/items/3e3f625af82016ef1287
- https://qiita.com/hashimotom92/items/44fdced2b81846972a7d
- https://qiita.com/chatrate/items/82ee6ecaa58e7529746b
- https://qiita.com/YoungjaeKwon/items/e6e12a3a5158bc02d5b5
- https://hadoop.apache.org/releases.html
- https://hadoop.apache.org/docs/r3.3.0/hadoop-project-dist/hadoop-common/SingleCluster.html
- https://cwiki.apache.org/confluence/display/HADOOP/Hadoop+Java+Versions
