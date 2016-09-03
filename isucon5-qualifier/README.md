# azure-isucon-templates/isucon5-qualifier

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fisucon5-qualifier%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fmatsuu%2Fazure-isucon-templates%2Fmaster%2Fisucon5-qualifier%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to create a Virtual Machines for ISUCON5 qualifier. This template also deploys a Virtual Network, Public IP addresses, Network Interfaces, and a Storage Account.

## 本来の設定と異なるところ

- 本番のインスタンスはn1-highcpu-4(GCE)でしたが、このテンプレートで起動するVMはF4 Standardです
- ベンチマークはCLIから手動で実行する必要があります

## FAQ

### 検証エラーが発生しました

エラーの詳細に「Operation results in exceeding quota limits of Core」と出ている場合、起動できるVMのコア数上限に引っかかっています。
サーバのスペックを1段階下げて起動するか、既に起動しているVMがある場合は削除してから実行してください。

なお、Visual Studio Dev Essentialsのサブスクリプションの場合、コア数の上限は合計4個までとなっているようです。

### サーバへの接続方法がわからない

設定したSSH公開鍵を使ってisuconユーザにssh接続が可能です。

    ssh isucon@(パブリックIPアドレス)

### ログインしてみたら中途半端な状態なんだけど？

サーバ起動とデプロイ後にAnsibleによるプロビジョニングが始まります。
プロビジョニングの進捗は `/var/log/cloud-init-output.log` で確認が可能です。

    tail -f /var/log/cloud-init-output.log

## TODO

* プロビジョニングの進捗をわかりやすくする
* もうちょっと説明を加える

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
