######################################################################
# Public Hosted Zone参照の設定
######################################################################

# 登録済みドメインをTerraformで扱えるようdata化
resource "aws_route53_zone" "prac-terraform" {

  # 利用するドメイン名を設定
  name = "stanaya-prac-terraform.tk"
}


######################################################################
# 公開Webサーバー用ドメイン設定
# ALB用設定に変更
######################################################################

# 公開Webサーバー用のレコード構築
resource "aws_route53_record" "web" {

  # レコードを記述するホストゾーンのID
  zone_id = aws_route53_zone.prac-terraform.zone_id

  # レコード名を設定
  # data化したドメインのZone Apexをレコード登録
  name    = aws_route53_zone.prac-terraform.name

  # レコードの種類をAに設定
  type    = "A"

  # エイリアスレコードを登録
  alias {

    # ALBのNDS名を設定
    name                   = aws_lb.web.dns_name

    # ALBの所属するゾーンIDを設定
    zone_id                = aws_lb.web.zone_id

    # このレコードにヘルスチェックを行う設定
    evaluate_target_health = true
  }
}
