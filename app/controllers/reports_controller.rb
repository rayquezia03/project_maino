class ReportsController < ApplicationController
  def index
    @reports = get_report_documents

    @nome_emitente_options = FiltersService.nome_emitente_options || []
    @cnpj_emitente_options = FiltersService.cnpj_emitente_options || []
    @nome_destinatario_options = FiltersService.nome_destinatario_options || []
    @uf_emitente_options = FiltersService.uf_emitente_options || []
  end

  private

  def get_report_documents
    excluded_keys = ["commit", "controller", "action"]
  
    filtered_params = params.to_unsafe_h.each_with_object({}) do |(key, value), hash|
      hash[key] = value unless excluded_keys.include?(key) || value.nil? || value.strip.empty?
    end

    query = Document.includes(:operation_products).all

    filtered_params.each do |key, value|
      query = query.where(key => value) if value.present?
    end

    filtered_documents = query

 
    nome_emitente = params.dig(:filter, :nome_emitente).to_s.strip
    cnpj_emitente = params.dig(:filter, :cnpj_emitente).to_s.strip
    nome_destinatario = params.dig(:filter, :nome_destinatario).to_s.strip
    uf_emitente = params.dig(:filter, :uf_emitente).to_s.strip
    produto = params.dig(:filter, :produto).to_s.strip
  
    filtered_documents = filtered_documents.where(nome_emitente: nome_emitente) if nome_emitente.present?
    filtered_documents = filtered_documents.where(cnpj_emitente: cnpj_emitente) if cnpj_emitente.present?
    filtered_documents = filtered_documents.where(nome_destinatario: nome_destinatario) if nome_destinatario.present?
    filtered_documents = filtered_documents.where(uf_emitente: uf_emitente) if uf_emitente.present?
  
    filtered_document_ids = filtered_documents.pluck(:id)
    operation_products = OperationProduct.where(document_id: filtered_document_ids)
    taxas = Taxa.where(document_id: filtered_document_ids)
  
    reports = filtered_documents.map do |document|
      {
        document: document,
        products: operation_products.select { |product| product.document_id == document.id },
        taxas: taxas.select { |taxa| taxa.document_id == document.id }
      }
    end
  
    reports
  end  

  def reset_database
    Document.delete_all
    OperationProduct.delete_all
    Taxa.delete_all

    redirect_to reports_path
  end
end