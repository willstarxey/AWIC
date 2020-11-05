class CreateEstrategiaCriterios < ActiveRecord::Migration[6.0]
  def change
    create_table :estrategia_criterios do |t|
      t.text :descripcion
      t.integer :ciclo, null: false, default: 1
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
