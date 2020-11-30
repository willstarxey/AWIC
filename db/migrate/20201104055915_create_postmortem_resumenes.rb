class CreatePostmortemResumenes < ActiveRecord::Migration[6.0]
  def change
    create_table :postmortem_resumenes do |t|
      t.string :ciclo, null: false
      t.text :detalles, null: true
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
      t.belongs_to :proyecto, foreign_key: true
    end
  end
end
