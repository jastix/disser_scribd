class AddScribd < ActiveRecord::Migration
  def self.up
	add_column :themes, :avtoref_pdf_scribd_id, :integer
	add_column :themes, :avtoref_pdf_scribd_access_key, :string
	add_column :themes, :disser_pdf_scribd_id, :integer
	add_column :themes, :disser_pdf_scribd_access_key, :string
  end

  def self.down
	remove_column :themes, :avtoref_pdf_scribd_id, :integer
	remove_column :themes, :avtoref_pdf_scribd_access_key, :string
	remove_column :themes, :disser_pdf_scribd_id, :integer
	remove_column :themes, :disser_pdf_scribd_access_key, :string
  end
end
