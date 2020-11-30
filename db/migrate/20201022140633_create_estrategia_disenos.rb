class CreateEstrategiaDisenos < ActiveRecord::Migration[6.0]
  def change
    create_table :estrategia_disenos do |t|
      t.text :descripcion_producto
      t.string :tamano
      t.integer :ciclo, null: false, default: 1
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
