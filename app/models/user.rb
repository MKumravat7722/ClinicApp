class User < ApplicationRecord
  enum role: { recipient: 'recipient', doctor: 'doctor' }
  has_many :patients
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  def serializable_hash(options = {})
    super(options.merge(except: [:password_digest]))
  end
end
