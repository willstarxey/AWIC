class CreateEtrategiaCriterios < ActiveRecord::Migration[6.0]
  def change
    create_table :etrategia_criterios do |t|

      t.timestamps
    end
  end
end
