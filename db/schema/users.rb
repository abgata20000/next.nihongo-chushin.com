create_table :users, comment: 'ユーザー情報' do |t|
  t.integer :room_id, null: true, comment: '部屋ID'
  t.string :name, null: true, comment: 'ユーザー名'
  t.string :nickname, null: true, comment: 'ユーザー名(ニックネーム)'
  t.string :token, null: true, comment: 'トークン'
  t.integer :role, null: false, default: 1, comment: '権限'
  t.string :color, null: true, comment: '色'
  t.string :icon, null: true, comment: 'アイコン'
  t.string :sound, null: true, comment: '効果音'
  t.string :language, null: false, default: 'ja', comment: '言語'
  t.boolean :is_connected, null: true, default: false, comment: '接続判定'
  t.boolean :is_mobile, null: true, default: false, comment: 'Mobile'
  t.boolean :enabled, null: false, default: true, comment: '有効・無効'
  t.datetime :into_the_room_at, null: true
  t.datetime :last_commented_at, null: true
  t.datetime :last_connected_at, null: true
  t.datetime :last_logged_in_at, null: true, comment: '最終ログイン時間'
  t.text :memo, null: true, comment: 'メモ'
  t.text :ip, null: true, comment: 'IP'
  t.timestamps
  #
  t.index :name, unique: true
  t.index :token, unique: true
  t.index :room_id
  t.index :language
  t.index :into_the_room_at
  t.index :last_commented_at
  t.index :last_connected_at
  t.index :last_logged_in_at
  t.index :updated_at
end
