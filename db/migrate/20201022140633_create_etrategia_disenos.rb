class CreateEtrategiaDisenos < ActiveRecord::Migration[6.0]
  def change
    create_table :etrategia_disenos do |t|
      t.text :descripcion
      t.string :tamano
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
