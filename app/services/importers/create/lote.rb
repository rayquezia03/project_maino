require 'zip'

module Importers
    module Create
      class Lote
        def initialize(document_lote)
          @document_lote = document_lote
          @errors = []
        end
  
        def process
            Zip::File.open(@document_lote) do |zip_file|
              zip_file.each do |entry|
                if entry.file? && File.extname(entry.name) == '.xml'
                  xml_content = entry.get_input_stream.read 
                  document = create_document(entry,xml_content,xml_content)
                  
                  Importers::Xml.new(@document).process
                end
              end
            end
          end
          
  
        private
  
        def create_document(document,file_xml,file_name_xml)
          @document = Document.find_by(document_name: file_name_xml)
  
          if @document
            @document.update(file_xml: file_xml, content_type: 'XML')
          else
            @document = ::Document.create(document_name: file_name_xml, file_xml: file_xml, content_type: 'XML')
          end
        end
      end
    end
  end