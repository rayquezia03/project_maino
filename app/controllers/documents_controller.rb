class DocumentsController < ApplicationController
  before_action :authenticate_user! 

  def new
    
  end

  def create
    if api_params[:import_type] == 'zip'
      create_import_lote
    else
      @service = Importers::IndividualCreate.new(api_params[:file].read, api_params[:file].original_filename)
      @service.call
    end
  end

  def create_import_lote
    @document_lote = api_params[:file]
    
    temp_file_path = Rails.root.join('tmp', @document_lote.original_filename)
    File.open(temp_file_path, 'wb') do |file|
      file.write(@document_lote.read)
    end
  
    ImporterLotesXmlJob.perform_later(temp_file_path.to_s)
  end
  
  

  def export
    @documents = Document.includes(:operation_products, :taxas).all
  
    @report_data = @documents.map do |document|
      produtos = document.operation_products.map do |produto|
        {
          nome: produto.nome.to_s.strip.squeeze(' '),
          ncm: produto.ncm.to_s.strip.squeeze(' '),
          cfop: produto.cfop.to_s.strip.squeeze(' '),
          unidade_comercializada: produto.unidade_comercializada.to_s.strip.squeeze(' '),
          quantidade_comercializada: produto.quantidade_comercializada.to_s.strip.squeeze(' '),
          valor_unitario: produto.valor_unitario.to_s.strip.squeeze(' ')
        }
      end
  
      taxas = document.taxas.first || {}
      {
        serie: document.serie.to_s.strip.squeeze(' '),
        nNF: document.nNF.to_s.strip.squeeze(' '),
        dhEmi: document.dhEmi.to_s.strip.squeeze(' '),
        emitente: {
          nome: document.nome_emitente.to_s.strip.squeeze(' '),
          cnpj: document.cnpj_emitente.to_s.strip.squeeze(' ')
        },
        destinatario: {
          nome: document.nome_destinatario.to_s.strip.squeeze(' '),
          cnpj: document.cnpj_destinatario.to_s.strip.squeeze(' ')
        },
        produtos: produtos,
        impostos: {
          vICMS: taxas.valor_icms.to_s.strip.squeeze(' '),
          vIPI: taxas.valor_ipi.to_s.strip.squeeze(' '),
          vPIS: taxas.valor_pis.to_s.strip.squeeze(' '),
          vCOFINS: taxas.valor_cofins.to_s.strip.squeeze(' ')
        },
        totalizadores: {
          total_produtos: produtos.sum { |p| p[:valor_unitario].to_f * p[:quantidade_comercializada].to_f },
          total_impostos: (taxas.valor_icms.to_f +
                           taxas.valor_ipi.to_f +
                           taxas.valor_pis.to_f +
                           taxas.valor_cofins.to_f)
        }
      }
    end
  
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="export.xlsx"'
        render xlsx: 'export'
      end
    end
  end
  
  private

  def api_params
    params.to_unsafe_h || {}
  end
end
