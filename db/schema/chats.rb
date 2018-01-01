create_table :chats, comment: 'チャット' do |t|
  t.integer :user_id, null: true, comment: 'ユーザーID'
  t.integer :room_id, null: false, comment: '部屋ID'
  t.string :nickname, null: true, comment: 'コメントした時のニックネーム'
  t.string :color, null: true, comment: 'コメント時の色'
  t.string :icon, null: true, comment: 'コメント時のアイコン'
  t.text :comment, null: true, comment: 'コメント内容'
  t.boolean :system_message, null: false, default: true, comment: 'システムメッセージかどうかの判定'
  t.datetime :deleted_at, null: true, comment: '削除時間'
  t.timestamps

  t.index :user_id
  t.index :room_id
  t.index :deleted_at
  t.index :created_at
  t.index :updated_at
end
