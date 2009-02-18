class OrganizationsController < ApplicationController
	layout 'application'
	require_role [:admin, :manager]
def new
		  @organization = Organization.new
end

  def create
  	@organization = Organization.new(params[:organization])
  	if @organization.save
  		redirect_to :action => 'list'
  	else
  		render :action => 'new'
 	end
 end

 def list
 	@organizations = Organization.find(:all)
	end

 def delete
	Organization.find(params[:id]).destroy
	redirect_to :action => :list
 end

def edit
  	@organization = Organization.find(params[:id])
end

def update
  	@organization = Organization.find(params[:id])
  	if @organization.update_attributes(params[:organization])
  		redirect_to :action => :list
 	else
 		render :action => :edit , :id => @organization
	end
end

end
