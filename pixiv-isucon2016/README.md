# azure-isucon-templates/pixiv-isucon2016

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fpixiv-isucon2016%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fpixiv-isucon2016%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to create a Virtual Machines for Pixiv ISUCON 2016. This template also deploys a Virtual Network, Public IP addresses, Network Interfaces, and a Storage Account.

これは[Pixiv社内ISUCON](http://inside.pixiv.net/entry/2016/05/18/115206)のサーバ構成をMicrosoft Azureで再現するためのテンプレートです。上に表示されているデプロイ用ボタンをクリックすることでMicrosoft Azureに一発デプロイが可能です。

## 事前準備

以下を用意してください

* Micorosoft Azureのアカウント
* SSH公開鍵

## サーバ構成

* image
    * 競技者用
* bench
    * ベンチマーカー

選択可能なサーバスペックは以下のとおりです。

| サイズ         | CPUコア数 | メモリ | 備考       |
| -------------- | --------- | ------ | ---------- |
| `Standard_F1s` |         1 |    2GB |            |
| `Standard_F2s` |         2 |    4GB | デフォルト |
| `Standard_F4s` |         4 |    8GB |            |
| `Standard_F8s` |         8 |   16GB |            |

スペックの詳細については[公式サイト](https://azure.microsoft.com/ja-jp/documentation/articles/virtual-machines-linux-sizes/)を参照してください。

なお、Pixivさん社内で実施された際のサーバスペックは以下のとおりです。

| 種別           | タイプ    | CPUコア数 | メモリ |
| -------------- | --------- | --------- | ------ |
| 競技者用       | c4.large  |         2 | 3.75GB |
| ベンチマーカー | c4.xlarge |         4 | 7.50GB |

## 本来の設定と異なるところ

* Azureにおけるプロビジョニングのしやすさから、DebianをUbuntuに置き換えています

## FAQ

### Azure管理画面が使いにくい

AzureはCLI周りが充実しておりCLIから起動することも可能です。詳細については[公式サイトのドキュメント](https://azure.microsoft.com/ja-jp/documentation/articles/virtual-machines-linux-cli-deploy-templates/)を参照してください。

### 検証エラーが発生しました

エラーの詳細に「Operation results in exceeding quota limits of Core」と出ている場合、起動できるVMのコア数上限に引っかかっています。
サーバのスペックを1段階下げて起動するか、既に起動しているVMがある場合は削除してから実行してください。

なお、Visual Studio Dev Essentialsのサブスクリプションの場合、コア数の上限は合計4個までとなっているようです。Quotaの設定はAzure CLIで確認が可能です。

    azure vm list-usage
    azure quotas show

詳細は[公式サイトのドキュメント](https://azure.microsoft.com/ja-jp/documentation/articles/resource-manager-common-deployment-errors/)を参照してください。

### サーバへの接続方法がわからない

設定したSSH公開鍵を使ってisuconユーザにssh接続が可能です。

    ssh isucon@(パブリックIPアドレス)

### SSH接続ができない

公開鍵の記述が正しくない可能性はないでしょうか。

### ログインしてみたら中途半端な状態なんだけど？

サーバ起動とデプロイ後にAnsibleによるプロビジョニングが始まります。
プロビジョニングの進捗は `/var/log/cloud-init-output.log` で確認が可能です。

    tail -f /var/log/cloud-init-output.log

### Ansibleによるプロビジョニングでエラーが発生した

Issueを立てて頂ければ幸いです。
プロビジョニング用のソースは`/mnt`配下にあります。
プロビジョニングを実行するスクリプトは`/var/lib/cloud/instance/user-data.txt`にあります。

### ベンチマークの実行方法がわからない

ベンチマーカーにisuconユーザでログイン後、以下のコマンドでベンチマークを実行できます。

    /opt/go/bin/benchmarker -t http://(競技者用のIPアドレス)/ -u /opt/go/src/github.com/catatsuy/private-isu/benchmarker/userdata

## TODO

* プロビジョニングの進捗をわかりやすくする
* もうちょっと説明を加える
* 追加ディスクを活用する

## License

MIT

## References

* [ISUCON6出題チームが社内ISUCONを開催！AMIも公開！！ - pixiv inside](http://inside.pixiv.net/entry/2016/05/18/115206)
* [catatsuy/private-isu](https://github.com/catatsuy/private-isu)
* [社内ISUCON 当日マニュアル](https://github.com/catatsuy/private-isu/blob/master/manual.md)
* [matsuu/vagrant-pixiv-isucon2016](https://github.com/matsuu/vagrant-pixiv-isucon2016)
* [matsuu/terraform-pixiv-isucon2016](https://github.com/matsuu/terraform-pixiv-isucon2016)

## Author

[matsuu](https://github.com/matsuu)
