# mailman-ui

## なにこれ
わかりやすい mailman の web ui を提供する

## できること

 - メンバーの 登録, 削除, 変更, 一覧
 - 保存書庫閲覧
 - 保留メール一覧, 流す流さない (一括, 個別)
 - 管理者変更

## つかいかた

`$ npm install`

## git おれおれフロー

### ブランチ名 命名規則
 - master  : develop ブランチを merge する. 動くことが保証されているブランチ
 - develop : dev, bug, issue などその他のブランチを merge する
 - dev/    : 開発ブランチ. dev/ui のように名前をつける
 - bug/    : master, develop ブランチでバグが見つかったら登場する.
 - issue/  : ある程度開発が進んで，機能を実装する場合に, issue を立て, その番号ブランチ名に含める
 
