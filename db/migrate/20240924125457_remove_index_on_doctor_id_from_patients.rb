class RemoveIndexOnDoctorIdFromPatients < ActiveRecord::Migration[7.0]
  def change
    remove_index :patients, name: "index_patients_on_doctor_id"
    remove_column :patients, :doctor_id, :bigint
  end
end
