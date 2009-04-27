class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
    	t.column :grade_name, :text, :null => false

    end
  end

  def self.down
    drop_table :grades
  end
end

