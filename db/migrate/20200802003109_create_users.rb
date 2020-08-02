class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      # Database User Values
      t.string :nombre
      t.string :app
      t.string :apm
      t.integer :edad
      t.string :sexo
      t.string :puesto
    end
  end
end
