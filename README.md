# next.nihongo-chushin.com
このプロジェクトは nihongo-chushin.com をRails に置き換えるためのものです。

全機能の置き換えは考えておらず、ひとまず最低限のチャットができるようになることが目標です。

- https://nihongo-chushin.com
- https://next.nihongo-chushin.com

## Rails version
- 5.1.4

## Ruby version
- 2.7.2

## System dependencies
- PostgreSQL 9.5.2

### Configuration
- オブジェクト指向を意識して書くこと
- DRYを意識して書くこと

## Rails settings
- bundleの実行
通常通り `bundle install` で `gem` のインストールをお願いします。

- 環境変数設定用に `.env` を作成
`.env.sample` を参考 `.env` を作成してください。
※環境変数の変更後反映するにはRailsの再起動が必要です。

## Database settings
- database.ymlを作成します
```
cp config/database.yml.sample config/database.yml
```
中身はご自身の環境に合わせて適宜変更ください
DATABASEの作成もご自身の環境に合わせて作成してください

- ridgepole を利用しています。
DBスキーマ反映用にタスクを作成しているので
```
bundle exec rails db:ridgepole
```
で反映されます。

## Other settings
- Sidekiq を利用しています。
```
bundle exec sidekiq -C config/sidekiq.yml
```
で railsとは別に立ち上げる必要があります。
※そのうち `foreman` 導入するかも
