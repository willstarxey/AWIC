class CreateEtrategiaCriterios < ActiveRecord::Migration[6.0]
  def change
    create_table :etrategia_criterios do |t|
      t.text :descripcion
      t.integer :ciclo
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
