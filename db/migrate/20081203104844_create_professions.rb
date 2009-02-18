class CreateProfessions < ActiveRecord::Migration
  def self.up
    create_table :professions do |t|
	t.column :profession_name, :text, :null => false
	t.column :code_name, :text, :null => false
	t.column :grade_id, :integer, :null => false
	#t.column :area_id, :integer
    end
  end

  def self.down
    drop_table :professions
  end
end
