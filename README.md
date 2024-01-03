# Smiley-Days

このSmiley-daysというアプリは、子育て奮闘中のパパママやおじいちゃん・おばあちゃんに向けたサイトとなっております。
おでかけがしたいけど、どこでおむつ替えができるのかわからなくて不安。子供とおでかけするのに、毎回同じようなところになってしまって、新しく遊べるところが知りたい！
そういったお子様とのお出かけに関して、遊び場や休憩スポットを共有できるアプリケーションです。


# このサイトのURLはこちら→[ https://smiley-days.net/ ]

__⇩⇩Smiley-days トップページ⇩⇩__
<img width="1320" alt="top" src="https://github.com/hacro/step_pf/assets/87082685/c5c0a4d9-6787-438d-aa49-136c2b2ae14a">



__⇩⇩Smiley-days ポスト一覧画面に表示される投稿です⇩⇩__
<img width="1275" alt="index" src="https://github.com/hacro/step_pf/assets/87082685/f0d436ef-d378-465c-871d-24fc78bf04c0">



__⇩⇩Smiley-days コメントもできます！⇩⇩__
<img width="1209" alt="comment" src="https://github.com/hacro/step_pf/assets/87082685/db7074b0-a4df-415a-81e0-15c3379ec1be">


# 目的

冒頭でも記載しましたが、小さなお子様とお出かけするには様々な不安があると思います。
おでかけをする時に、ここにはおむつ替えのシートがあってこの休憩室にはお湯のサーバーがあるなど、事前知識がついた状態であれば安心してお出かけができます。
また子供と出かけるとなると、子供が楽しめるところがいいと考える人が大半だと思います。
普段過ごしている地域の中でも、他の人の投稿を通じて新しい遊びスポットの発見ができたりだとか、あれば良い持ち物などを事前に知っておくことで、不安を感じずお出かけすることが可能になります。
そのような思いから、今回このWebアプリケーションを作成いたしました。

# AWS構成図
※構成図ではEC2インスタンスの冗長化としておりますが、コスト面での考慮のため現状は一台での構成となっております。
![AWS_composition](https://github.com/hacro/step_pf/assets/87082685/38c72979-2c6c-4d0c-b377-ca545652a706)

# 使用技術
 - Ruby 3.1.2
 - Ruby on Rails 6.1.4
 - MySQL 5.7.43
 - Nginx
 - Puma
 - Docker
 - AWS
   - VPC
   - EC2
   - RDS
   - Route 53
- RSpec
- devise
- Google Maps Platform
- Ajax
- kaminari

# 詳細設計・ER図・テーブル定義書
https://docs.google.com/spreadsheets/d/14mIQhioY1YKtvsVjWl1ZG2QvLKN39cc6dulF_HBMMS4/edit#gid=0







