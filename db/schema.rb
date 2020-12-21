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

ActiveRecord::Schema.define(version: 2020_11_04_055915) do

  create_table "colaboradors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "proyecto_id"
    t.datetime "added_at", null: false
    t.boolean "lider", null: false
    t.index ["proyecto_id"], name: "index_colaboradors_on_proyecto_id"
    t.index ["user_id"], name: "index_colaboradors_on_user_id"
  end

  create_table "diseno_estandares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre", null: false
    t.text "descripcion", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.bigint "diseno_tipo_estandar_id"
    t.index ["colaborador_id"], name: "index_diseno_estandares_on_colaborador_id"
    t.index ["diseno_tipo_estandar_id"], name: "index_diseno_estandares_on_diseno_tipo_estandar_id"
  end

  create_table "diseno_estructuras", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre", null: false
    t.text "descripcion", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_diseno_estructuras_on_colaborador_id"
  end

  create_table "diseno_plan_pruebas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre", null: false
    t.text "descripcion", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_diseno_plan_pruebas_on_colaborador_id"
  end

  create_table "diseno_tipos_estandares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre", null: false
    t.text "descripcion", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "proyecto_id"
    t.index ["proyecto_id"], name: "index_diseno_tipos_estandares_on_proyecto_id"
  end

  create_table "estrategia_criterios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "descripcion"
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_estrategia_criterios_on_colaborador_id"
  end

  create_table "estrategia_disenos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "descripcion_producto"
    t.string "tamano"
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_estrategia_disenos_on_colaborador_id"
  end

  create_table "estrategia_estimaciones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "funcion", null: false
    t.text "descripcion", null: false
    t.integer "tamano", null: false
    t.integer "tiempo", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_estrategia_estimaciones_on_colaborador_id"
  end

  create_table "implementacion_criterios_calidad", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "descripcion", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_implementacion_criterios_calidad_on_colaborador_id"
  end

  create_table "lanzamiento_metas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "descripcion", default: "", null: false
    t.string "plazo", default: "", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_lanzamiento_metas_on_colaborador_id"
  end

  create_table "planeacion_planes_calidad", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "actividad", null: false
    t.text "descripcion", null: false
    t.string "tamano", null: false
    t.integer "tiempo", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_planeacion_planes_calidad_on_colaborador_id"
  end

  create_table "postmortem_resumenes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "ciclo", null: false
    t.text "detalles"
    t.json "lanzamiento_metas", null: false
    t.json "estrategia_criterios", null: false
    t.json "estrategia_disenos", null: false
    t.json "estrategia_estimaciones", null: false
    t.json "planeacion_planes_calidad", null: false
    t.json "requerimientos_requerimientos", null: false
    t.json "diseno_estandares", null: false
    t.json "diseno_estructuras", null: false
    t.json "diseno_planes_pruebas", null: false
    t.json "implementacion_criterios_calidad", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "proyecto_id"
    t.index ["proyecto_id"], name: "index_postmortem_resumenes_on_proyecto_id"
  end

  create_table "proyectos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "descripcion", default: ""
    t.integer "n_ciclos", default: 0
    t.integer "ciclo_actual", default: 1, null: false
    t.boolean "finalizado", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pruebas_pruebas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre", null: false
    t.text "descripcion"
    t.text "entrada"
    t.text "r_obtenido"
    t.text "r_deseado"
    t.boolean "cumple", default: false, null: false
    t.integer "ciclo", default: 1, null: false
    t.json "lanzamiento_metas"
    t.json "estrategia_criterios"
    t.json "estrategia_disenos"
    t.json "estrategia_estimaciones"
    t.json "planeacion_planes_calidad"
    t.json "requerimientos_requerimientos"
    t.json "diseno_estandares"
    t.json "diseno_estructuras"
    t.json "diseno_planes_pruebas"
    t.json "implementacion_criterios_calidad"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_pruebas_pruebas_on_colaborador_id"
  end

  create_table "requerimientos_requerimientos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "descripcion", null: false
    t.string "fuente", null: false
    t.string "tipo", null: false
    t.string "ambiente", null: false
    t.text "restricciones", null: false
    t.string "procesos", null: false
    t.integer "ciclo", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "colaborador_id"
    t.index ["colaborador_id"], name: "index_requerimientos_requerimientos_on_colaborador_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  add_foreign_key "colaboradors", "proyectos"
  add_foreign_key "colaboradors", "users"
  add_foreign_key "diseno_estandares", "colaboradors"
  add_foreign_key "diseno_estandares", "diseno_tipos_estandares"
  add_foreign_key "diseno_estructuras", "colaboradors"
  add_foreign_key "diseno_plan_pruebas", "colaboradors"
  add_foreign_key "diseno_tipos_estandares", "proyectos"
  add_foreign_key "estrategia_criterios", "colaboradors"
  add_foreign_key "estrategia_disenos", "colaboradors"
  add_foreign_key "estrategia_estimaciones", "colaboradors"
  add_foreign_key "implementacion_criterios_calidad", "colaboradors"
  add_foreign_key "lanzamiento_metas", "colaboradors"
  add_foreign_key "planeacion_planes_calidad", "colaboradors"
  add_foreign_key "postmortem_resumenes", "proyectos"
  add_foreign_key "pruebas_pruebas", "colaboradors"
  add_foreign_key "requerimientos_requerimientos", "colaboradors"
  add_foreign_key "users", "roles"
end
