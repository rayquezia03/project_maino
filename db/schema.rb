# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_08_14_024021) do

  create_table "documents", force: :cascade do |t|
    t.string "cUF"
    t.string "cNF"
    t.string "natOp"
    t.string "mod"
    t.integer "serie"
    t.integer "nNF"
    t.datetime "dhEmi"
    t.string "tpNF"
    t.string "idDest"
    t.string "cMunFG"
    t.string "tpImp"
    t.string "tpEmis"
    t.string "cDV"
    t.string "tpAmb"
    t.string "chave_acesso"
    t.string "nome_emitente"
    t.string "cnpj_emitente"
    t.string "logradouro_emitente"
    t.integer "numero_emitente"
    t.string "bairro_emitente"
    t.string "municipio_emitente"
    t.string "uf_emitente"
    t.string "cep_emitente"
    t.string "nome_destinatario"
    t.string "cnpj_destinatario"
    t.string "logradouro_destinatario"
    t.integer "numero_destinatario"
    t.string "bairro_destinatario"
    t.string "municipio_destinatario"
    t.string "uf_destinatario"
    t.string "cep_destinatario"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "document_name"
    t.string "file_xml"
    t.string "content_type"
  end

  create_table "operation_products", force: :cascade do |t|
    t.string "nome"
    t.string "ncm"
    t.string "cfop"
    t.string "unidade_comercializada"
    t.decimal "quantidade_comercializada", precision: 10, scale: 2
    t.decimal "valor_unitario", precision: 10, scale: 2
    t.decimal "valor_total", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "document_id"
    t.index ["document_id"], name: "index_operation_products_on_document_id"
  end

  create_table "taxas", force: :cascade do |t|
    t.decimal "valor_icms", precision: 10, scale: 2
    t.decimal "valor_ipi", precision: 10, scale: 2
    t.decimal "valor_pis", precision: 10, scale: 2
    t.decimal "valor_cofins", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "document_id"
    t.index ["document_id"], name: "index_taxas_on_document_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "address"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
