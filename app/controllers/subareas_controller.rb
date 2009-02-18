class SubareasController < ApplicationController

	def list
		@subareas = Subarea.find(:all)
	end

	def new
		@subarea = Subarea.new
	end

	def edit
		@subarea = Subarea.find(params[:id])
	end

	def create
		@subarea = Subarea.new(params[:subarea])
	  	if @subarea.save
  		redirect_to :action => 'list'
  		else
  		render :action => :new
 		end
	end

	def update
		@subarea = Subarea.find(params[:id])
  		if @subarea.update_attributes(params[:subarea])
  		redirect_to :action => :list
 		else
 		render :action => :edit , :id => @subarea
		end
	end

	def delete
		Subarea.find(params[:id]).destroy
		redirect_to :action => :list
	end
end
