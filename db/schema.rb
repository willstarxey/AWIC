# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_15_185701) do

  create_table "colaboradors", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "proyecto_id"
    t.datetime "added_at", null: false
    t.boolean "lider", null: false
    t.index ["proyecto_id"], name: "index_colaboradors_on_proyecto_id"
    t.index ["user_id"], name: "index_colaboradors_on_user_id"
  end

  create_table "lanzamiento_metas", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "descripcion", default: "", null: false
    t.string "plazo", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_lanzamiento_metas_on_colaborador_id"
  end

  create_table "proyectos", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "descripcion", default: ""
    t.integer "n_ciclos", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "app", null: false
    t.string "apm", null: false
    t.integer "edad", null: false
    t.string "sexo", null: false
    t.string "puesto", null: false
    t.bigint "role_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
