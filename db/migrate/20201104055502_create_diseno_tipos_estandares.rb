class CreateDisenoTiposEstandares < ActiveRecord::Migration[6.0]
  def change
    create_table :diseno_tipos_estandares do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.timestamps
      t.belongs_to :proyecto, foreign_key: true
    end
  end
end
