class CreateDisenoPlanPruebas < ActiveRecord::Migration[6.0]
  def change
    create_table :diseno_plan_pruebas do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.integer :ciclo, null: false, default: 1
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
