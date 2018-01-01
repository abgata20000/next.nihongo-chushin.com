create_table :rooms, comment: '部屋情報' do |t|
  t.integer :user_id, null: false, comment: 'オーナーユーザーID'
  t.string :name, null: false, comment: '部屋名'
  t.string :password, null: true, comment: 'パスワード'
  t.string :language, null: false, default: 'ja', comment: '言語'
  t.boolean :can_knock, null: false, default: false, comment: 'ノック可能かどうか'
  t.boolean :is_public, null: false, default: false, comment: '公開部屋フラグ'
  t.boolean :is_visible, null: false, default: true, comment: '表示・非表示'
  t.boolean :is_fixed, null: false, default: false, comment: '固定部屋'
  t.integer :connection_disconnected_time, null: false, default: 60, comment: '接続切れからの強制退出までの時間'
  t.integer :comment_disconnected_time, null: false, default: 600, comment: '最終コメントから強制退出までの時間'
  t.integer :num, null: false, default: 5, comment: '人数'
  t.integer :show_comment_count, null: false, default: 100, comment: '表示するコメント数'
  t.text :memo, null: true, comment: 'メモ'
  t.datetime :deleted_at, null: true, comment: '削除時間'
  t.timestamps

  t.index :user_id
  t.index :language
  t.index :deleted_at
  t.index :created_at
  t.index :updated_at
end
