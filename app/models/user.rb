class User < ApplicationRecord
  validates :password, confirmation: true
  has_many :borrowings
  has_many :borrowed_books, through: :borrowings, source: :book
  has_many :reviews
  enum status: { signin: 0, signout: 1 }
  enum role: { regular_user: 0, library_admin: 1 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_otp
    self.otp = ROTP::TOTP.new(Rails.application.credentials[:otp_secret]).now
    self.otp_expiry = 10.minutes.from_now
    save!
    return self.otp
  end

  def verify_otp(entered_otp)
    return false if otp_expiry < Time.now

    valid = ROTP::TOTP.new(Rails.application.credentials[:otp_secret]).verify(entered_otp, drift_behind: 30)
    update(otp: nil, otp_expiry: nil, otp_verified: true) if valid
    valid
  end
end
