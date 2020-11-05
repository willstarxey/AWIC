class CreateImplementacionCriteriosCalidad < ActiveRecord::Migration[6.0]
  def change
    create_table :implementacion_criterios_calidad do |t|
      t.text :descripcion, null: false
      t.integer :ciclo, null: false, default: 1
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
