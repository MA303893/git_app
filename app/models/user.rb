class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :omniauthable


  before_save :ensure_authentication_token!

  has_one :school, dependent: :destroy

  scope :schools, -> { where(user_type: 'school') }

  BLACKLIST_FOR_SERIALIZATION = [:auth_token, :id]

  def generate_secure_token_string
    # SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
    Devise.friendly_token(50)
  end

  # Sarbanes-Oxley Compliance: http://en.wikipedia.org/wiki/Sarbanes%E2%80%93Oxley_Act
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  def password_presence
    password.present? && password_confirmation.present?
  end

  def password_match
    password == password_confirmation
  end

  def ensure_authentication_token!
    if auth_token.blank?
      self.auth_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(auth_token: token).first
    end
  end

  def reset_authentication_token!
    self.auth_token = generate_authentication_token
    self.save
  end

  def serializable_hash(options = nil)
    options ||= {}
    options[:except] = Array(options[:except])
    options[:except].concat BLACKLIST_FOR_SERIALIZATION
    super(options)
  end
end
