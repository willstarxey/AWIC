class CreateEtrategiaDisenos < ActiveRecord::Migration[6.0]
  def change
    create_table :etrategia_disenos do |t|

      t.timestamps
    end
  end
end
