class AddThemesSubAreas < ActiveRecord::Migration
  def self.up
      create_table :subareas_themes, :id => false do |t|
	t.column :subarea_id, :integer
	t.column :theme_id, :integer

	end
  end

  def self.down
	drop_table :subareas_themes
  end

end
