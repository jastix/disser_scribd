class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
	t.column :theme_name, :string, :null => false
	t.column :fio, :string, :null => false
	t.column :year_name , :string, :null => false
	t.column :text_abstract, :longtext, :null => false
	t.column :text_dissertation, :longtext, :null => false
	t.column :profession_id, :integer
	t.column :organization_id, :integer
	t.column :avtoref_doc_file_name, :string
	t.column :avtoref_doc_content_type, :string
	t.column :avtoref_doc_file_size, :integer
	t.column :avtoref_pdf_file_name, :string
	t.column :avtoref_pdf_content_type, :string
	t.column :avtoref_pdf_file_size, :integer
	t.column :disser_doc_file_name, :string
	t.column :disser_doc_content_type, :string
	t.column :disser_doc_file_size, :integer
	t.column :disser_pdf_file_name, :string
	t.column :disser_pdf_content_type, :string
	t.column :disser_pdf_file_size, :integer
	t.column :delta, :boolean
      t.timestamps

    end
  end

  def self.down
    drop_table :themes
  end
end
