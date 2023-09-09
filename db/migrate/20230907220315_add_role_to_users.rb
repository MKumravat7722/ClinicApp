class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    # Remove the previous change_column line
    # change_column :users, :role, :integer, using: 'role::integer'

    # Define the enum values and set the default
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE user_role AS ENUM ('recipient', 'doctor');
          ALTER TABLE users ADD COLUMN role user_role DEFAULT 'recipient';
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP TYPE user_role;
        SQL
      end
    end
  end
end
