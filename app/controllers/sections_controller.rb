class SectionsController < ApplicationController
  CHAR_LIST = ("a".."z").to_a + ("0".."9").to_a
  def index
    path = "section_data/Section_#{params[:section]}.xml"
    @section_id = params[:section]
    @doc = Nokogiri::XML(File.open(path))
    @client_datum = current_user.client_data.where(:section => @section_id).first
    if !@client_datum.nil?
      @section_data = JSON.parse(@client_datum.data)
    end
  end 
  def submit
    params[:files].each do |name, file|
      directory = "uploads"
      extension = "." + file.original_filename.split(".").last
      rand_file_name = rand_file << extension
      path = Rails.root.join(directory, rand_file_name)
      File.open(path, "wb") { |f| f.write(file.read) }
      doc = Document.new
      doc.original_filename = file.original_filename
      doc.doc_name = name
      doc.filename = path.to_s
      doc.save
    end

    @answers = params[:answers].to_json
    section_id = params[:section]
    c = current_user.client_data.where(:section => section_id).first
    if c.nil?
      c = ClientDatum.new
      current_user.client_data.push(c)
    end
    c.section = section_id
    c.data = @answers 
    c.save   
  end
  def rand_file 
    filefound = false
    while !filefound do
      str=""
      16.times do |i|
        str << CHAR_LIST[rand(CHAR_LIST.length)]
      end
      if !File.exist?(str)
         break
      end
    end 
    puts "str =" + str
    str
  end
end
