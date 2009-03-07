class ThemesController < ApplicationController
	layout 'application'
require_role [:admin, :manager], :for_all_except => [:list, :show, :show_abstract, :show_avtoref_swf]


  def list
  	if current_user.blank? then redirect_to root_path
 		end
  	@areas = Area.find(:all)
  	@grades = Grade.find(:all)
  	@organizations = Organization.find(:all)
	@professions = Profession.find(:all)

	page = params[:page] || 1
@search = Theme.search params[:q], :match_mode => :extended,
  	 :field_weights => { :theme_name => 20, :fio => 15 },:page => page,  :per_page => 10

  	@themes = @search
  	@paging = @search

  end

  def new
  	  	@areas = ""
		@subareas = ""
  		@grades = ""
  		@organizations = Organization.find(:all)
		@professions = Profession.find(:all)
		@theme = Theme.new

  end

  def show
  	if current_user.blank? then redirect_to root_path
 		end
  	@areas = Area.find(:all)
  	@grades = Grade.find(:all)
  	@professions = Profession.find(:all)
  	@organizations = Organization.find(:all)
  	@theme = Theme.find(params[:id])
  end



  def create
	params[:theme][:area_ids] ||= []
	params[:theme][:subarea_ids] ||= []
  	@areas = Area.find(:all)
  	@grades = Grade.find(:all)
	@subareas = ""
  	@professions = Profession.find(:all)
  	@organizations = Organization.find(:all)
  	@theme = Theme.new(params[:theme])

  	if @theme.save
		@theme.create_swf_avtoref unless @theme.avtoref_pdf.url.nil?
		@theme.create_swf_disser unless @theme.disser_pdf.url.nil?
		@theme.update_attributes(params[:theme])
		#@theme.update_attribute(:avtoref_pdf, params[:theme][:avtoref_pdf])
		#@theme.update_attribute(:disser_pdf, params[:theme][:disser_pdf])
  		redirect_to :action => :list
 	else
 		render :action => :new
	end




	end

  def edit

  	@areas = ""
	@subareas = ""
  	@grades = ""
  	@professions = Profession.find(:all)
  	@organizations = Organization.find(:all)
  	@theme = Theme.find(params[:id])


  end

  def update
	params[:theme][:area_ids] ||= []
	params[:theme][:subarea_ids] ||= []
  	@areas = Area.find(:all)
	@subareas = Subarea.find(:all)
  	@grades = Grade.find(:all)
  	@professions = Profession.find(:all)
  	@organizations = Organization.find(:all)
  	@theme = Theme.find(params[:id])

  	if @theme.update_attributes(params[:theme])
		@theme.create_swf_avtoref
		@theme.create_swf_disser unless @theme.disser_pdf.url.nil?
		@theme.update_attributes(params[:theme])
		#@theme.update_attribute(:avtoref_pdf, params[:theme][:avtoref_pdf])
		#@theme.update_attribute(:disser_pdf, params[:theme][:disser_pdf])
  		redirect_to :action => :list
 	else
 		render :action => :edit , :id => @theme
	end
  end


 def delete
	Theme.find(params[:id]).destroy
	redirect_to :controller => :themes, :action => :list
 end

 def show_abstract
 	if current_user.blank? then redirect_to root_path
 		end
 	@theme = Theme.find(params[:id])
end


 def show_disser

 	@theme = Theme.find(params[:id])
end


def download_avtoref_doc
	@theme = Theme.find(params[:id])
	# путь к файлу после папки public = @theme.avtoref_doc.url
	send_file ("#{RAILS_ROOT}" + "/" + "public" + @theme.avtoref_doc.url)
end

def download_avtoref_pdf
	@theme = Theme.find(params[:id])
	# путь к файлу после папки public = @theme.avtoref_doc.url
	send_file ("#{RAILS_ROOT}" + "/" + "public" + @theme.avtoref_pdf.url)
end

def download_disser_doc
	@theme = Theme.find(params[:id])
	# путь к файлу после папки public = @theme.avtoref_doc.url
	send_file ("#{RAILS_ROOT}" + "/" + "public" + @theme.disser_doc.url)
end

def download_disser_pdf
	@theme = Theme.find(params[:id])
	# путь к файлу после папки public = @theme.avtoref_doc.url
	send_file ("#{RAILS_ROOT}" + "/" + "public" + @theme.disser_pdf.url)
end
	def update_grades

		profession = Profession.find(params[:profession_id])

		@grades = eval("[profession.grade]")
		#@areas = Area.find(:all)

		render :update do |page|
			#page.replace_html 'areas', :partial => 'areas', :object => @areas
			page.replace_html 'grades', :partial => 'grades', :object => @grades
		end
	end

	def update_areas
		#area = Area.find(params[:area_id])
		@subareas = Subarea.find(:all)#area.subareas

		render :update do |page|
			page.replace_html 'subareas', :partial => 'subareas', :object => @subareas
		end

	end

	def show_avtoref_swf
		@theme = Theme.find(params[:id])
		render :action => :show_avtoref_swf , :layout => false
	end

	def show_disser_swf
		@theme = Theme.find(params[:id])
		render :action => :show_disser_swf , :layout => false
	end


end
