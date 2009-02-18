class AddSwf < ActiveRecord::Migration
  def self.up
	add_column :themes, :avtoref_swf_file_name, :string
	add_column :themes, :avtoref_swf_content_type, :string
	add_column :themes, :avtoref_swf_file_size, :integer
	add_column :themes, :disser_swf_file_name, :string
	add_column :themes, :disser_swf_content_type, :string
	add_column :themes, :disser_swf_file_size, :integer
  end

  def self.down
	remove_column :themes, :avtoref_swf_file_name
	remove_column :themes, :avtoref_swf_content_type
	remove_column :themes, :avtoref_swf_file_size
	remove_column :themes, :disser_swf_file_name
	remove_column :themes, :disser_swf_content_type
	remove_column :themes, :disser_swf_file_size
  end
end
