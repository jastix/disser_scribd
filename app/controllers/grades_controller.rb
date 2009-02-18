class GradesController < ApplicationController
		layout 'application'
		require_role [:admin, :manager]

	def new
		  @grade = Grade.new

  end

  def create
  	@grade = Grade.new(params[:grade])
  	if @grade.save
  		redirect_to :action => :list
  	else
  	render :action => :new
 	end
end

def list
	@grades = Grade.find(:all)
end

 def delete
	Grade.find(params[:id]).destroy
	redirect_to :action => :list
 end

def edit
  	@grade = Grade.find(params[:id])
end

def update
  	@grade = Grade.find(params[:id])
  	if @grade.update_attributes(params[:grade])
  		redirect_to :action => :list
 	else
 		render :action => :edit , :id => @grade
	end
end

end
