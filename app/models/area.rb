class Area < ActiveRecord::Base
	#has_many :professions
	#has_many :professions_areas
	#has_many :professions , :through => :professions_areas
has_and_belongs_to_many :professions
has_and_belongs_to_many :subareas
has_and_belongs_to_many :themes
attr_accessible :area_ids
end
