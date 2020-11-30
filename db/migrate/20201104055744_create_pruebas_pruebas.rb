class CreatePruebasPruebas < ActiveRecord::Migration[6.0]
  def change
    create_table :pruebas_pruebas do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.text :entrada, null: false
      t.text :r_obtenido, null: false
      t.text :r_deseado, null: false
      t.boolean :cumple, null: false, default: false
      t.integer :ciclo, null: false, default: 1
      t.json :lanzamiento_metas, null: false
      t.json :estrategia_criterios, null: false
      t.json :estrategia_disenos, null: false
      t.json :estrategia_estimaciones, null: false
      t.json :planeacion_planes_calidad, null: false
      t.json :requerimientos_requerimientos, null: false
      t.json :diseno_estandares, null: false
      t.json :diseno_estructuras, null: false
      t.json :diseno_planes_pruebas, null: false
      t.json :implementacion_criterios_calidad, null: false
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
