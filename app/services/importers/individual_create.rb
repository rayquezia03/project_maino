class Importers::IndividualCreate
  def initialize(file_xml, file_name_xml)
    @file_xml = file_xml
    @file_name_xml = file_name_xml
    @errors = []
  end

  def call
    create_document
    process
  end

  private

  def process
    begin
      ImporterXmlJob.perform_later(@document)
    rescue StandardError => e
      @errors << e.message
      p "#{e}"
    end
  end

  def create_document
    @document = Document.find_by(document_name: @file_name_xml)

    if @document
      @document.update(file_xml: @file_xml, content_type: 'XML')
    else
      @document = ::Document.create(document_name: @file_name_xml, file_xml: @file_xml, content_type: 'XML')
    end
  end
end