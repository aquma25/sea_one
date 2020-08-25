class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, # DBに保存されたパスワードが正しいかどうかの検証とを行う。またパスワードの暗号化も同時に行う。
         :registerable,             # User自身がアカウント登録、編集、削除することを許可する
         :recoverable,              # パスワードをリセットできるようにし、メールで通知する
         :rememberable,             # ３０日間ログインしたままにするというような永続ログインを可能にする。ログイン画面の下のチェックボックスにチェックすることで永続ログインを有効化可能
         :validatable,              # Emailやパスワードのバリデーションを可能にする。独自に定義したバリデーションを追加することも可能
         :confirmable               # メールに記載されているURLをクリックして本登録を完了するメール認証を行う。また、ログイン中にアカウントが認証済みかどうかの検証を行う
         #:omniauthable             # Gmailの認証ログインを追加したい場合に使用する
end
