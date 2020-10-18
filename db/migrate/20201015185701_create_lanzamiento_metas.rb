class CreateLanzamientoMetas < ActiveRecord::Migration[6.0]
  def change
    create_table :lanzamiento_metas do |t|
      t.string :descripcion, null: false, default: ""
      t.string :plazo, null: false, default: ""
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
