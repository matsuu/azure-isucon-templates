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

## License

MIT

## References

- [ISUCON5 予選レギュレーション](http://isucon.net/archives/45347574.html)
- [ISUCON5 予選マニュアル](https://gist.github.com/tagomoris/1a2df5ab0999f5e64cff)
- [isucon/isucon5-qualify](https://github.com/isucon/isucon5-qualify)
- [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
- [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)

## Author

[matsuu](https://github.com/matsuu)
