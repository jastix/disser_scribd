class Subarea < ActiveRecord::Base
	has_and_belongs_to_many :areas
	validates_uniqueness_of :subarea_name
	validates_presence_of :subarea_name
end
