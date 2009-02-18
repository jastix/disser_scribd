class Profession < ActiveRecord::Base
	belongs_to :grade
	#belongs_to :area
	#has_many :professions_areas
	#has_many :areas , :through => :professions_areas
	has_and_belongs_to_many :areas
	has_many :themes
	validates_uniqueness_of :profession_name
	validates_presence_of :profession_name

	before_validation :edit_name
private
	def edit_name
		self.profession_name = profession_name + " " + "(" + self.areas.collect{|ar| ar.area_name}.join(",") + ")"
	end
end
