class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      # Database User Values
      t.string :nombre, null: false
      t.string :app, null: false
      t.string :apm, null: false
      t.integer :edad, null: false
      t.string :sexo, null: false
      t.string :puesto, null: false
      #Foreign Key from Role for User
      t.belongs_to :role, null: false, foreign_key: true
    end
  end
end
