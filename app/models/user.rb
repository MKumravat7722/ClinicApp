class User < ApplicationRecord
  enum role: { recipient: 'recipient', doctor: 'doctor' }
  has_many :patients
  has_one :doctor
  has_one :doctor, foreign_key: "user_id" # Assuming the foreign key for the doctor in patients is "user_id"
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end