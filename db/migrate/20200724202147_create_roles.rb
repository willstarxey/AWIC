class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      #Database Roles values
      t.string :nombre
      t.string :descripcion
      t.timestamps
      #Roles
    end
  end
end
