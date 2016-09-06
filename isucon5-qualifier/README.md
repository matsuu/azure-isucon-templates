# azure-isucon-templates/isucon5-qualifier

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fisucon5-qualifier%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fisucon5-qualifier%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to create a Virtual Machines for ISUCON5 qualifier. This template also deploys a Virtual Network, Public IP addresses, Network Interfaces, and a Storage Account.

これはISUCON5予選のサーバ構成をMicrosoft Azureで再現するためのテンプレートです。上に表示されているデプロイ用ボタンをクリックすることでMicrosoft Azureに一発デプロイが可能です。

## 事前準備

以下を用意してください

* Micorosoft Azureのアカウント
* SSH公開鍵

## 構成

* image
    * チューニング対象のサーバ
* bench
    * ベンチマーク用サーバ

選択可能なサーバスペックは以下のとおりです。

| サイズ         | CPUコア数 | メモリ |
| -------------- | --------- | ------ |
| `Standard_F1s` |         1 |    2GB |
| `Standard_F2s` |         2 |    4GB |
| `Standard_F4s` |         4 |    8GB |
| `Standard_F8s` |         8 |   16GB |

スペックの詳細については[公式サイト](https://azure.microsoft.com/ja-jp/documentation/articles/virtual-machines-linux-sizes/)を参照してください。

なお、予選当日のサーバスペックはn1-highcpu-4(CPU4コア、メモリ3.6GB)でした。

## 本来の設定と異なるところ

* Ubuntu 15.10はAzureで用意されていないためUbuntu 16.04に置き換えています
* Ubuntuのバージョン変更に合わせてMySQLはMariaDBに変更しています
* ベンチマークはCLIから手動で実行する必要があります

## FAQ

### Azure管理画面が使いにくい

AzureはCLI周りが充実しておりCLIから起動することも可能です。詳細については[公式サイトのドキュメント](https://azure.microsoft.com/ja-jp/documentation/articles/virtual-machines-linux-cli-deploy-templates/)を参照してください。

### 検証エラーが発生しました

エラーの詳細に「Operation results in exceeding quota limits of Core」と出ている場合、起動できるVMのコア数上限に引っかかっています。
サーバのスペックを1段階下げて起動するか、既に起動しているVMがある場合は削除してから実行してください。

なお、Visual Studio Dev Essentialsのサブスクリプションの場合、コア数の上限は合計4個までとなっているようです。Quotaの設定はAzure CLIで確認が可能です。

    azure vm list-usage

詳細は[公式サイトのドキュメント](https://azure.microsoft.com/ja-jp/documentation/articles/resource-manager-common-deployment-errors/)を参照してください。

### サーバへの接続方法がわからない

設定したSSH公開鍵を使ってisuconユーザにssh接続が可能です。

    ssh isucon@(パブリックIPアドレス)

### ログインしてみたら中途半端な状態なんだけど？

サーバ起動とデプロイ後にAnsibleによるプロビジョニングが始まります。
プロビジョニングの進捗は `/var/log/cloud-init-output.log` で確認が可能です。

    tail -f /var/log/cloud-init-output.log

### Ansibleによるプロビジョニングでエラーが発生した

Issueを立てて頂ければ幸いです。
プロビジョニング用のソースは`/mnt`配下にあります。
プロビジョニングを実行するスクリプトは`/var/lib/cloud/instance/user-data.txt`にあります。

### ベンチマークの実行方法がわからない

ベンチマーク用サーバにisuconユーザでログイン後、ホームディレクトリにあるbench.shでベンチマークを実行できます。

    /home/isucon/bench.sh (チューニング対象サーバのIPアドレス)

### MySQLへの接続エラーになる

MariaDBに変更した関係から、MySQLへの接続にrootアカウントを使用しているプログラム実装(goなど)はmysqlへの接続に失敗します。
mysqlの接続アカウントを isucon / isucon に変更してください。

## TODO

* プロビジョニングの進捗をわかりやすくする
* もうちょっと説明を加える
* mysql接続エラー周りを修正する

## License

MIT

## References

* [ISUCON5 予選レギュレーション](http://isucon.net/archives/45347574.html)
* [ISUCON5 予選マニュアル](https://gist.github.com/tagomoris/1a2df5ab0999f5e64cff)
* [isucon/isucon5-qualify](https://github.com/isucon/isucon5-qualify)
* [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
* [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)

## Author

[matsuu](https://github.com/matsuu)
