class CreatePruebasPruebas < ActiveRecord::Migration[6.0]
  def change
    create_table :pruebas_pruebas do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: true
      t.text :entrada, null: true
      t.text :r_obtenido, null: true
      t.text :r_deseado, null: true
      t.boolean :cumple, null: false, default: false
      t.integer :ciclo, null: false, default: 1
      t.json :lanzamiento_metas, null: true
      t.json :estrategia_criterios, null: true
      t.json :estrategia_disenos, null: true
      t.json :estrategia_estimaciones, null: true
      t.json :planeacion_planes_calidad, null: true
      t.json :requerimientos_requerimientos, null: true
      t.json :diseno_estandares, null: true
      t.json :diseno_estructuras, null: true
      t.json :diseno_planes_pruebas, null: true
      t.json :implementacion_criterios_calidad, null: true
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
