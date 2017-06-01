# aws構築用shell

terraform/hashicorpを使う


### インストール

+ Mac

```
$ brew update
$ brew install terraform
```

+ terraform version

```
$ terraform -v
Terraform v0.9.5
```

### 認証情報を作成

```
$ cp -a credentials.json.sample credentials.json
```

### terraformを使ってネットワークを作成

+ 設定ファイル

```
aszoo-aws-main.tf
```


+ 設定ファイルを元にAWS上にネットワークを構築


```
$ sh tf-build.sh
```


+ 設定ファイルを元にAWS上にネットワークを構築したものを削除

```
$ sh tf-remove.sh
```
