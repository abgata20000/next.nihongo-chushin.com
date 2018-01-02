create_table :premium_users, comment: 'プレミアムユーザー情報' do |t|
  t.integer :user_id, null: true, comment: 'ユーザーID'
  t.string :name, null: true, comment: 'ユーザー名'
  t.string :email, null: true, comment: 'メールアドレス'
  t.string :password, null: true, comment: 'パスワード'
  t.text :memo, null: true, comment: 'メモ'
  t.text :ip, null: true, comment: 'IP'
  t.timestamps
  #
  t.index :name, unique: true
  t.index :email, unique: true
  t.index :user_id
end
