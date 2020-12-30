################################################################
# Web サーバー用 Public Subnet
################################################################

#  ap-northeast-1 の availability zoneにWeb サーバー用のサブネットを構築
resource "aws_subnet" "public_a" {
  # サブネットを構築するVPCのIDを設定
  # [vpc.tf]で記述したVPCを変数で指定
  vpc_id = aws_vpc.vpc.id

  # サブネットが使用するcidrを指定
  # VPCの範囲内でsubnetに割り当てるCIDRを区切る
  cidr_block = "10.0.1.0/24"

  # サブネットを配置するAvailability Zone を東京リージョン1aに設定
  availability_zone = "ap-northeast-1a"

  # このサブネットで起動したインスタンスにパブリックIPを割り当てる
  map_public_ip_on_launch = true

  # タグを設定
  tags = {
    Name = "pub-a"
  }
}

######################################################################
# APサーバー用 Private Subnet
######################################################################

#  ap-northeast-1 の availability zoneにAPIサーバー用のサブネットを構築
resource "aws_subnet" "private_a" {
  # サブネットを構築するVPCのIDを設定
  # [vpc.tf]で記述したVPCを変数で指定
  vpc_id = aws_vpc.vpc.id

  # サブネットが使用するcidrを指定
  # VPCの範囲内でsubnetに割り当てるCIDRを区切る
  cidr_block = "10.0.2.0/24"

  # サブネットを配置するAvailability Zone を東京リージョン1aに設定
  availability_zone = "ap-northeast-1a"

  # タグを設定
  tags = {
    Name = "priv-a"
  }
}

######################################################################
# ALB用追加 Public Subnet
######################################################################

#ALB マルチAZ用サブネットを追加構築
resource "aws_subnet" "public_c" {

  # サブネットを構築するVPCのIDを設定
  # [vpc.tf]にて記述したVPCを変数で指定
  vpc_id            = aws_vpc.vpc.id

  # サブネットが使用するcidrを設定
  # VPCの範囲内でSubnetに割り当てるCIDRを区切る
  cidr_block        = "10.0.5.0/24"

  # サブネットを配置するAvailability Zoneを東京リージョン1cに設定
  # ALBでマルチAZ設定にするため1aと重複しない設定
  availability_zone = "ap-northeast-1c"

  # このサブネットで起動したインスタンスにパブリックIPを割り当てる
  map_public_ip_on_launch = true

  # タグを設定
  tags = {
    Name = "pub-c"
  }
}
