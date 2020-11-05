class CreateEstrategiaEstimaciones < ActiveRecord::Migration[6.0]
  def change
    create_table :estrategia_estimaciones do |t|
      t.string :funcion, null: false
      t.text :descripcion, null: false
      t.integer :tamano, null: false
      t.integer :tiempo, null: false
      t.integer :ciclo, null: false, default: 1
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
