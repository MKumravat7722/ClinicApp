class AddFieldsToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :gender, :string
    add_column :patients, :contact_number, :string
    add_column :patients, :date_time_of_appointment, :datetime
  end
end
