class CreateRequerimientosRequerimientos < ActiveRecord::Migration[6.0]
  def change
    create_table :requerimientos_requerimientos do |t|
      t.text :descripcion, null: false
      t.string :fuente, null: false
      t.string :tipo, null: false
      t.string :ambiente, null: false
      t.text :restricciones, null: false
      t.string :procesos, null: false
      t.integer :ciclo, null: false, default: 1
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
