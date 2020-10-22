class CreatePlaneacionPlanesCalidad < ActiveRecord::Migration[6.0]
  def change
    create_table :planeacion_planes_calidad do |t|
      t.string :actividad, null: false
      t.text :descripcion, null: false
      t.string :tamano, null: false
      t.int :tiempo, null: false
      t.timestamps
      t.belongs_to :colaborador, foreign_key: true
    end
  end
end
