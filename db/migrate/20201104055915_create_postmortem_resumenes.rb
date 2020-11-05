class CreatePostmortemResumenes < ActiveRecord::Migration[6.0]
  def change
    create_table :postmortem_resumenes do |t|
      t.string :ciclo, null: false
      t.text :descripcion, null: false
      t.json :lanzamiento, null: false
      t.json :estrategia, null: false
      t.json :planeacion, null: false
      t.json :requerimientos, null: false
      t.json :diseno, null: false
      t.json :implementacion, null: false
      t.timestamps
      t.belongs_to :proyecto, foreign_key: true
    end
  end
end
