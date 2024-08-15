class ImporterXmlJob < ActiveJob::Base
  queue_as :importers

  def perform(document)
    Importers::Xml.new(document).process 
  end
end
