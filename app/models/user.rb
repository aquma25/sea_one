class User < ApplicationRecord

  # DB Relation
  has_many :sns_credentials, dependent: :destroy

  # Validation
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i #半角英数字のみ
  validates :nick_name, presence: true, uniqueness: true, length: { maximum: 8 }, format: { with: VALID_PASSWORD_REGEX }

  devise :database_authenticatable,                          # DBに保存されたパスワードが正しいかどうかの検証とを行う。またパスワードの暗号化も同時に行う。
         :registerable,                                      # User自身がアカウント登録、編集、削除することを許可する
         :recoverable,                                       # パスワードをリセットできるようにし、メールで通知する
         :rememberable,                                      # ３０日間ログインしたままにするというような永続ログインを可能にする。ログイン画面の下のチェックボックスにチェックすることで永続ログインを有効化可能
         :validatable,                                       # Emailやパスワードのバリデーションを可能にする。独自に定義したバリデーションを追加することも可能
         :confirmable,                                       # メールに記載されているURLをクリックして本登録を完了するメール認証を行う。また、ログイン中にアカウントが認証済みかどうかの検証を行う
         :omniauthable, omniauth_providers: [:google_oauth2] # Gmailの認証ログインを追加したい場合に使用する

  # static method
  class << self
    # 渡されたuidをuser情報と紐付けて保存する
    def from_omniauth(auth)
      user = User.where(email: auth.info.email).first
      SnsCredential.where(provider: auth.provider, uid: auth.uid, user_id: user&.id).first_or_create
      user
    end
  end

end
