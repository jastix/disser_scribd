class AreasController < ApplicationController
			layout 'application'
			require_role [:admin, :manager]
  def new
		  @area = Area.new

  end

  def create
	#@subareas = Subarea.find(:all)
  	@area = Area.new(params[:area])
  	if @area.save
  		redirect_to :action => 'list'
  	else
  		render :action => :new
 	end
	end

def list
	@areas = Area.find(:all)
end

 def delete
	Area.find(params[:id]).destroy
	redirect_to :action => :list
 end


def edit
	@subareas = Subarea.find(:all)
  	@area = Area.find(params[:id])
end

def update
	@subareas = Subarea.find(:all)
  	@area = Area.find(params[:id])
	params[:area][:subarea_ids] ||= []
  	if @area.update_attributes(params[:area])
  		redirect_to :action => :list
 	else
 		render :action => :edit , :id => @area
	end
end



end
