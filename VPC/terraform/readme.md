# AWS上のVPC環境をTerraformを用いて構築していく

[Terraform by HashiCorp](https://www.terraform.io/)


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
aws-main.tf
```


+ 設定ファイルを元にAWS上にネットワークを構築


```
$ sh tf-build.sh
```


+ 設定ファイルを元にAWS上にネットワークを構築したものを削除

```
$ sh tf-remove.sh
```

+ 補足

暫定として設定ファイルはignoreしているが、構築する際はignoreを取ってgit管理したほうがよい
