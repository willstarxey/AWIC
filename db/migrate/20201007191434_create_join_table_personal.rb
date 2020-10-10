class CreateJoinTablePersonal < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :proyectos do |t|
      t.index [:user_id, :proyecto_id]
      t.index [:proyecto_id, :user_id]
      t.timestamp :added_at, null: false
      t.boolean :lider, null: false, default: false
    end
  end
end
