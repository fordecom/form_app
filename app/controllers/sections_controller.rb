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
    if !params[:files].nil? 
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
      redirect_to index_path and return
  	end

		path = "section_data/Section_#{params[:section]}.xml"
    @section_id = params[:section]
    @doc = Nokogiri::XML(File.open(path))

    @answers = validates(params[:answers], 0)
    puts @answers
		puts params[:answers]
    section_id = params[:section]
    c = current_user.client_data.where(:section => section_id).first
    if c.nil?
      c = ClientDatum.new
      current_user.client_data.push(c)
    end
    c.section = section_id
    c.data = @answers.to_json 
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

	private
		def validates(section_data, key)				
			if(section_data.is_a? Hash)
				ret = {}
       	section_data.each do |hash_key, val|
					ret[hash_key] = validates(val, hash_key)
				end
				ret
			else if(section_data.is_a? Array)
				ret = []
        section_data.each do |val|
					ret.push(validates(val, key))
				end
				ret
			else
				puts "key: #{key}"
        xp_query = "//*[@name='#{key}']"
        puts "xp_query: #{xp_query}"
        puts @doc.class
				node = @doc.xpath(xp_query)
				puts node
				puts "type #{node.xpath("@type").text}"
				puts "data #{node.xpath("@data").text}"

				case node.xpath("@type").text
					when "field"
					case node.xpath("@data").text
						when "date"		
							begin
								DateTime.parse(section_data)
							rescue Exception
								return Date.current().to_s
							end
							return DateTime.parse(section_data).to_s
						when "text"
							if section_data.blank? or section_data.length>65000	
								return ""
							else 
								return section_data
							end
						when "integer"
							if section_data.blank?
								return 0
							else
								return section_data.to_i
							end
						end					
					end	
				end
			end
		end
	end
