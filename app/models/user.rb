class User < ApplicationRecord

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validate :password_complexity

  has_secure_password

  def password_complexity
    if password.present?
       if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/)
         errors.add :password, "Password complexity requirement not met"
       end
    end
  end

end
