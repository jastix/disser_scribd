class ProfessionsController < ApplicationController
	layout 'application'
	require_role [:admin, :manager]
	def new
		@areas = Area.find(:all)
		@grades = Grade.find(:all)
		  @profession = Profession.new

  end
	  def create
	  	@areas = Area.find(:all)
		@grades = Grade.find(:all)
		#@profession.areas = Area.find(@params[:area_ids]) if params[:area_ids]

  	@profession = Profession.new(params[:profession])
  	if @profession.save
  		redirect_to :action => 'list'
  	else
  		render :action => 'new'
 	end

 end
def list
	@professions = Profession.find(:all)
end

  def delete
	Profession.find(params[:id]).destroy
	redirect_to :action => :list
 end

def edit
	@areas = Area.find(:all)
  	@grades = Grade.find(:all)
  	@profession = Profession.find(params[:id])
end

def update
	@areas = Area.find(:all)
	@grades = Grade.find(:all)
	params[:profession][:area_ids] ||= []
  	@profession = Profession.find(params[:id])
  	if @profession.update_attributes(params[:profession])
  		redirect_to :action => "list"
 	else
 		render :action => :edit, :id => @profession
	end
end

end
