class ReportsController < ApplicationController
  def index
    @reports = fetch_reports

    @uf_emitente_options = Document.pluck(:uf_emitente).uniq
    @nome_emitente_options = FiltersService.nome_emitente_options || []
    @cnpj_emitente_options = FiltersService.cnpj_emitente_options || []
    @nome_destinatario_options = FiltersService.nome_destinatario_options || []
    @product_options = OperationProduct.pluck(:nome).uniq.sort.map { |produto| [produto, produto] }
  end

  private

  def fetch_reports
    
    documents = Document.includes(:operation_products, :taxas).all

    reports = documents.map do |document|
      {
        document: document,
        products: document.operation_products,
        taxas: document.taxas
      }
    end

    reports
  end

  def filtered_infos_to_return
    
    documents = Document.includes(:operation_products, :taxas).all

    reports = documents.map do |document|
      {
        document: document,
        products: document.operation_products,
        taxas: document.taxas
      }
    end

    reports
  end
end
