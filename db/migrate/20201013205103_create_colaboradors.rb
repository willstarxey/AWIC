class CreateColaboradors < ActiveRecord::Migration[6.0]
  def change
    create_table :colaboradors do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :proyecto, foreign_key: true
      t.datetime :added_at, null: false
      t.boolean :lider, null: false
    end
  end
end
