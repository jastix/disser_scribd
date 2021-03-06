class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
	t.column :area_name, :string, :null => :false

	create_table :areas_professions, :id => false do |t|
	t.column :area_id, :integer
	t.column :profession_id, :integer
end
    end
  end

  def self.down
    drop_table :areas
    drop_table :areas_professions
  end
end
