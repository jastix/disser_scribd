class Theme < ActiveRecord::Base

	belongs_to :profession
	belongs_to :organization
	has_and_belongs_to_many :areas
	has_and_belongs_to_many :subareas
	validates_uniqueness_of :theme_name
	validates_presence_of :theme_name
	validates_presence_of :fio
	validates_presence_of :year_name
	validates_presence_of :organization_id
	validates_presence_of :profession_id
	attr_accessible :fio, :theme_name, :text_abstract, :text_dissertation, :year_name, :organization_id, :profession_id, :avtoref_doc, :avtoref_pdf, :disser_doc, :disser_pdf, :avtoref_swf, :area_ids, :subarea_ids

before_save :edit_title, :edit_name
before_validation :attachment_check





	define_index do
		indexes fio
		indexes theme_name
		indexes text_abstract
		indexes text_abstract
		indexes year_name
		indexes [profession.profession_name, profession.code_name], :as => :profession
		indexes organization.organization_name, :as => :organization
		set_property :enable_star => 1
		set_property :min_prefix_len => 3
		set_property :delta => true

	end


	has_attached_file :avtoref_doc
	has_attached_file :avtoref_pdf
	has_attached_file :disser_doc
	has_attached_file :disser_pdf
	has_attached_file :avtoref_swf
	has_attached_file :disser_swf
	has_scribdable_attachment :avtoref_pdf
	has_scribdable_attachment :disser_pdf
	has_scribdable_attachment :avtoref_doc
	has_scribdable_attachment :disser_doc
	#validates_attachment_presence :avtoref_doc
	#validates_attachment_presence :avtoref_pdf
	#validates_attachment_presence :disser_doc
	#validates_attachment_presence :disser_pdfhas_scribdable_attachment :avtoref_pdf


	validates_attachment_content_type :avtoref_doc, :content_type => 'application/msword'
	validates_attachment_content_type :avtoref_pdf, :content_type => 'application/pdf'
	validates_attachment_content_type :disser_doc, :content_type => 'application/msword'
	validates_attachment_content_type :disser_pdf, :content_type => 'application/pdf'
	validates_attachment_content_type :avtoref_swf, :content_type => 'application/x-swf'
	validates_attachment_content_type :disser_swf, :content_type => 'application/x-swf'
	if :avtoref_pdf == nil
		validates_attachment_scribdability :avtoref_doc
	elsif :avtoref_doc == nil
		validates_attachment_scribdability :avtoref_pdf
	end
	#validates_attachment_scribdability :avtoref_pdf unless :avtoref_pdf != nil

	if :disser_pdf == nil
		validates_attachment_scribdability :disser_doc
	elsif :disser_doc == nil
		validates_attachment_scribdability :disser_pdf
	end
	#validates_attachment_scribdability :disser_pdf unless :disser_pdf != nil





	def edit_title
		#удаление кавычек в начале и конце строки и в начале строки
		if theme_name[0] == 34 and theme_name[-1] == 34 then
     			 self.theme_name = theme_name.slice(1...theme_name.length-1)
      		end


    		if theme_name[0] == 34  then
      		self.theme_name = theme_name.slice(1...theme_name.length)
      		end

	#первая буква заглавная
		self.theme_name = self.theme_name.split(' ').map {|line| line.humanize}.compact.join(" ")

	end

	def edit_name
		self.fio = self.fio.split(' ').map {|line| line.downcase.humanize}.compact.join(" ")
	end
def attachment_check
	if self.avtoref_pdf.exists? and self.avtoref_pdf. == nil
		then
	self.avtoref_pdf.url = self.avtoref_pdf.url
		end
end



	def create_swf_avtoref
		if  self.avtoref_swf.exists? and self.avtoref_pdf.url == "/avtoref_pdfs/original/missing.png" and  (self.avtoref_swf.original_filename[0...-4] == self.avtoref_pdf.original_filename)
		then
		#render :controller => :themes, :action => :new
		else
		view_path = "#{RAILS_ROOT}" + "/" + "public" + "/" + "rfxview.swf"
		pdf_path = "#{RAILS_ROOT}" + "/" + "public" + self.avtoref_pdf.url
		tmp_path = "#{RAILS_ROOT}" + "/" + "public" + "/" + "tmp" + "/" + 		self.avtoref_pdf.original_filename + ".swf"
		system("pdf2swf -B #{view_path} #{pdf_path} -o #{tmp_path}")

		self.avtoref_swf = File.new(tmp_path)

		File.delete(tmp_path)

		end
end


	def create_swf_disser

		if self.disser_swf.exists? and self.disser_pdf.url != "/disser_pdfs/original/missing.png"  and (self.disser_swf.original_filename[0...-4] == self.disser_pdf.original_filename)
		then

		else
		view_path = "#{RAILS_ROOT}" + "/" + "public" + "/" + "rfxview.swf"
		pdf_path = "#{RAILS_ROOT}" + "/" + "public" + self.disser_pdf.url
		tmp_path = "#{RAILS_ROOT}" + "/" + "public" + "/" + "tmp" + "/" + self.disser_pdf.original_filename + ".swf"
		system("pdf2swf -B #{view_path}  #{pdf_path} #{tmp_path}")

		self.disser_swf = File.new(tmp_path)

		File.delete(tmp_path)
		#else

		end

	end
end

