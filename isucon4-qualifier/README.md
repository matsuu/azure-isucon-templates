# azure-isucon-templates/isucon4-qualifier

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fisucon4-qualifier%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fisucon4-qualifier%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to create a Virtual Machines for ISUCON4 qualifier. This template also deploys a Virtual Network, Public IP addresses, Network Interfaces, and a Storage Account.

これは[ISUCON4予選](http://isucon.net/archives/41252218.html)のサーバ構成をMicrosoft Azureで再現するためのテンプレートです。上に表示されているデプロイ用ボタンをクリックすることでMicrosoft Azureに一発デプロイが可能です。

## 事前準備

以下を用意してください

* Micorosoft Azureのアカウント
* SSH公開鍵

## サーバ構成

* isucon4q
    * 参加者ノード

選択可能なサーバスペックは以下のとおりです。

| サイズ            | CPUコア数 | メモリ | 備考       |
| ----------------- | --------- | ------ | ---------- |
| `Standard_DS1_v2` |         1 |  3.5GB |            |
| `Standard_DS2_v2` |         2 |    7GB |            |
| `Standard_DS3_v2` |         4 |   14GB | デフォルト |
| `Standard_DS4_v2` |         8 |   28GB |            |

スペックの詳細については[公式サイト](https://azure.microsoft.com/ja-jp/pricing/details/virtual-machines/linux/)を参照してください。

なお、予選当日のサーバスペックは以下のとおりです。

| 種別         | タイプ    | CPUコア数 | メモリ |
| ------------ | --------- | --------- | ------ |
| 参加者ノード | m3.xlarge |         4 |   15GB |

## 本来の設定と異なるところ

- MySQLのバージョンを5.5.42からMySQL GA最新版(現在は5.6系)に変更しています
- ログインユーザをec2-userからisuconに変更しています
- ベンチマークプログラムのインスタンスチェックを削除しています

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
プロビジョニングの進捗は `/var/log/ansible.log` で確認が可能です。

    tail -f /var/log/ansible.log

### Ansibleによるプロビジョニングでエラーが発生した

Issueを立てて頂ければ幸いです。

### ベンチマークの実行方法がわからない

isuconユーザでログイン後、ホームディレクトリにあるbenchmarkerでベンチマークを実行できます。

    /home/isucon/benchmarker bench

## TODO

* プロビジョニングの進捗をわかりやすくする
* もうちょっと説明を加える

## License

MIT

## References

- [ISUCON4(2014) オンライン予選レギュレーション](http://isucon.net/archives/39979344.html)
- [ISUCON4 予選当日マニュアル](https://gist.github.com/mirakui/e394ed543415852d34a6)
* [isucon/isucon4](https://github.com/isucon/isucon4)
* [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
* [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)

## Author

[matsuu](https://github.com/matsuu)
