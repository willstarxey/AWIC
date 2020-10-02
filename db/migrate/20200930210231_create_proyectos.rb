class CreateProyectos < ActiveRecord::Migration[6.0]
  def change
    create_table :proyectos do |t|
      t.string :nombre, null: false
      t.string :descripcion, null: true, default: ""
      t.timestamps
      #Foreign Key from User for Project
      t.belongs_to :user, null: false, foreign_key: true
    end
  end
end
