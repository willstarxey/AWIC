class CreatePruebasPruebas < ActiveRecord::Migration[6.0]
  def change
    create_table :pruebas_pruebas do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.text :entrada, null: false
      t.text :r_obtenido, null: false
      t.text :r_deseado, null: false
      t.boolean :cumple, null: false, default: false
      t.json :lanzamiento, null: false
      t.json :estrategia, null: false
      t.json :planeacion, null: false
      t.json :requerimientos, null: false
      t.json :diseno, null: false
      t.json :implementacion, null: false
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
