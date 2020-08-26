class User < ApplicationRecord

  # DB Relation
  has_many :sns_credentials, dependent: :destroy

  devise :database_authenticatable,                          # DBに保存されたパスワードが正しいかどうかの検証とを行う。またパスワードの暗号化も同時に行う。
         :registerable,                                      # User自身がアカウント登録、編集、削除することを許可する
         :recoverable,                                       # パスワードをリセットできるようにし、メールで通知する
         :rememberable,                                      # ３０日間ログインしたままにするというような永続ログインを可能にする。ログイン画面の下のチェックボックスにチェックすることで永続ログインを有効化可能
         :validatable,                                       # Emailやパスワードのバリデーションを可能にする。独自に定義したバリデーションを追加することも可能
         :confirmable,                                       # メールに記載されているURLをクリックして本登録を完了するメール認証を行う。また、ログイン中にアカウントが認証済みかどうかの検証を行う
         :omniauthable, omniauth_providers: [:google_oauth2] # Gmailの認証ログインを追加したい場合に使用する

  # static method
  class << self
    def without_sns_data(auth)
      user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(uid: auth.uid, provider: auth.provider, user_id: user.id)
      else
        user = User.new(nick_name: auth.info.name, email: auth.info.email,)
        sns = SnsCredential.new(uid: auth.uid, provider: auth.provider)
      end
      { user: user, sns: sns }
    end

    def with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      user = User.new(nick_name: auth.info.name, email: auth.info.email) if user.blank?
      { user: user }
    end

    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first

      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end

      { user: user, sns: sns }
    end
  end
end
