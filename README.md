# mailman-ui

## なにこれ
わかりやすい mailman の web ui を提供する

## できること

 - メンバーの 登録, 削除, 変更, 一覧
 - 保存書庫閲覧
 - 保留メール一覧, 流す流さない (一括, 個別)
 - 管理者変更

## つかいかた

以下のような Apache の設定を書く

```httpd-ssl.conf

<VirtualHost *:443>
RewriteEngine On
RewriteMap authz prg:/path/to/mladmin-auth.pl

<Directory "/usr/local/mailman/cgi-bin">
  AllowOverride None
  Options FollowSymlinks ExecCGI

  AuthName "mailman administrator only."
  AuthType Basic
  AuthBasicProvider ldap
  AuthLDAPGroupAttributeIsDN off
  AuthLDAPGroupAttribute memberUid
  AuthLDAPURL "ldap://ldap.example.net/dc=example,dc=com?uid"
  Require valid-user

  RewriteEngine On
  RewriteBase /mailman
  RewriteCond ${authz:%{REQUEST_URI}:%{REMOTE_USER}} ng
  RewriteRule ^(.*)$ - [F]
</Directory>
</VirtualHost>
```

## git おれおれフロー

### ブランチ名 命名規則
 - master  : gh-pages ブランチを merge する. 動くことが保証されているブランチ
 - gh-pages : dev, bug, issue などその他のブランチを merge する
 - dev/    : 開発ブランチ. dev/ui のように名前をつける
 - bug/    : master, gh-pages ブランチでバグが見つかったら登場する.
 - issue/  : ある程度開発が進んで，機能を実装する場合に, issue を立て, その番号ブランチ名に含める

