class ImporterLotesXmlJob < ApplicationJob
  queue_as :importers

  def perform(temp_file_path)
    @service = Importers::Create::Lote.new(temp_file_path)
    @service.process
  end
end