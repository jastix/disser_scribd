class Grade < ActiveRecord::Base
	has_many :professions
	validates_uniqueness_of :grade_name
	validates_presence_of :grade_name

end

