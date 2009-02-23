class CreateSubareas < ActiveRecord::Migration
  def self.up
    create_table :subareas do |t|
    	t.column :subarea_name, :string, :null => false

      create_table :areas_subareas, :id => false do |t|
	t.column :area_id, :integer
	t.column :subarea_id, :integer
    end
  end
end

  def self.down
    drop_table :subareas
    drop_table :areas_subareas
  end
end
