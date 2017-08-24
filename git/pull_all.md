# 全てのリモートリポリトリからpullする

### 基本的には下記のcmdでいける

```
$ for i in `git branch -r`; do git branch --track ${remote#origin/} $remote; done
$ git fetch --all
$ git pull --all
```

### jenkinsでの使い方
