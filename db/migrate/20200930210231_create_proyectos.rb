class CreateProyectos < ActiveRecord::Migration[6.0]
  def change
    create_table :proyectos do |t|
      t.string :nombre, null: false
      t.string :descripcion, null: true, default: ""
      t.integer :n_ciclos, null: true, default: 0
      t.integer :ciclo_actual, null: false, default: 1
      t.boolean :finalizado, null: false, default: false
      t.timestamps
    end
  end
end
