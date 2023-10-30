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

ActiveRecord::Schema.define(version: 2023_10_25_225425) do

  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authors", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_papers", id: false, charset: "utf8", force: :cascade do |t|
    t.bigint "paper_id", null: false
    t.bigint "author_id", null: false
    t.integer "rank"
    t.index ["paper_id", "author_id"], name: "index_authors_papers_on_paper_id_and_author_id"
  end

  create_table "business_office_units", charset: "utf8", force: :cascade do |t|
    t.string "org_oid"
    t.string "dept_code"
    t.string "dept_official_name"
    t.string "dept_display_name"
    t.string "dept_abbrev"
    t.boolean "is_ucdhs"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "classifications", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "classifications_titles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "classification_id"
    t.integer "title_id"
  end

  create_table "delayed_jobs", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at", precision: 6
    t.datetime "locked_at", precision: 6
    t.datetime "failed_at", precision: 6
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departments", charset: "utf8", force: :cascade do |t|
    t.string "code", null: false
    t.string "officialName", null: false
    t.string "displayName"
    t.string "abbreviation", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bou_org_oid"
  end

  create_table "entities", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "first"
    t.string "last"
    t.string "email"
    t.string "loginid"
    t.boolean "active", default: true
    t.string "phone"
    t.string "address"
    t.text "description", size: :medium
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "logged_in_at", precision: 6
    t.boolean "is_employee"
    t.boolean "is_hs_employee"
    t.boolean "is_faculty"
    t.boolean "is_student"
    t.boolean "is_staff"
    t.boolean "is_external"
    t.integer "iam_id"
    t.datetime "synced_at", precision: 6
    t.index ["id"], name: "id", unique: true
    t.index ["id"], name: "index_entities_on_id"
    t.index ["loginid"], name: "index_entities_on_loginid"
    t.index ["name"], name: "index_entities_on_name"
    t.index ["type"], name: "index_entities_on_type"
  end

  create_table "group_children_assignments", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "group_id"
    t.integer "child_id"
  end

  create_table "group_memberships", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "group_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["id"], name: "id", unique: true
  end

  create_table "group_operator_assignments", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "group_id"
    t.integer "operator_person_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.integer "operator_group_id"
  end

  create_table "group_operatorships", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entity_id"
    t.index ["id"], name: "id", unique: true
  end

  create_table "group_owner_assignments", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "group_id"
    t.integer "owner_person_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.integer "owner_group_id"
  end

  create_table "group_ownerships", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entity_id"
  end

  create_table "group_rule_result_sets", charset: "latin1", force: :cascade do |t|
    t.string "column"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_rule_results", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "group_rule_result_set_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "group_rules", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "column"
    t.string "condition"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id"
    t.integer "group_rule_result_set_id"
    t.index ["id"], name: "id", unique: true
  end

  create_table "groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.integer "min_size"
    t.integer "max_size"
    t.text "description"
    t.string "code"
  end

  create_table "groups_people", id: false, charset: "utf8", force: :cascade do |t|
    t.integer "group_id"
    t.integer "person_id"
  end

  create_table "integration_metadata", charset: "latin1", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "majors", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
    t.index ["name"], name: "index_majors_on_name"
  end

  create_table "papers", charset: "utf8", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.text "abstract"
    t.integer "paper_number", null: false
    t.date "creation_date"
    t.text "keywords"
    t.integer "paper_length"
    t.text "classification_jel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "first"
    t.string "last"
    t.string "email"
    t.string "loginid"
    t.string "preferred_name"
    t.boolean "status"
    t.string "phone"
    t.string "address"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.integer "title_id"
    t.integer "major_id"
  end

  create_table "person_favorite_assignments", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.integer "entity_id"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "person_manager_assignments", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "person_id"
    t.integer "manager_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.integer "ou_id"
  end

  create_table "pps_associations", charset: "latin1", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "title_id", null: false
    t.integer "department_id", null: false
    t.integer "association_rank", null: false
    t.integer "position_type_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_department_id"
    t.integer "appt_department_id"
    t.integer "employee_class"
  end

  create_table "role_assignments", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id"
    t.integer "entity_id"
    t.integer "parent_id"
    t.index ["id"], name: "id", unique: true
    t.index ["role_id", "entity_id", "parent_id"], name: "index_role_assignments_on_role_id_and_entity_id_and_parent_id"
    t.index ["role_id", "entity_id"], name: "index_role_assignments_on_role_id_and_entity_id"
  end

  create_table "roles", id: { type: :bigint, unsigned: true }, charset: "latin1", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "application_id"
    t.string "name"
    t.string "description"
    t.string "ad_path"
    t.datetime "last_ad_sync", precision: 6
    t.string "ad_guid"
    t.index ["id"], name: "id", unique: true
    t.index ["id"], name: "index_roles_on_id"
  end

  create_table "sis_associations", charset: "latin1", force: :cascade do |t|
    t.integer "major_id"
    t.integer "entity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "level_code", limit: 2
    t.integer "association_rank"
  end

  create_table "student_levels", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "students", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "level_id"
    t.integer "person_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "titles", id: { type: :bigint, unsigned: true }, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "unit", limit: 3
    t.index ["code"], name: "index_titles_on_code"
    t.index ["id"], name: "id", unique: true
  end

  create_table "tracked_items", charset: "utf8", force: :cascade do |t|
    t.string "kind"
    t.integer "item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "loginid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "versioned_type"
    t.integer "versioned_id"
    t.string "user_type"
    t.integer "user_id"
    t.string "user_name"
    t.text "modifications"
    t.integer "number"
    t.integer "reverted_from"
    t.string "tag"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["created_at"], name: "index_versions_on_created_at"
    t.index ["number"], name: "index_versions_on_number"
    t.index ["tag"], name: "index_versions_on_tag"
    t.index ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type"
    t.index ["user_name"], name: "index_versions_on_user_name"
    t.index ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type"
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
