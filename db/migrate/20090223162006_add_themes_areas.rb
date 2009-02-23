class AddThemesAreas < ActiveRecord::Migration
  def self.up
      create_table :areas_themes, :id => false do |t|
	t.column :area_id, :integer
	t.column :theme_id, :integer

	end
  end

  def self.down
	drop_table :areas_themes
  end
end
