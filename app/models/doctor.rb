class Doctor < ApplicationRecord
    has_many :patients
    belongs_to :user
end
