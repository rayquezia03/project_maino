module Importers
  class Xml
    attr_reader :issues

    def initialize(document)
      @document = document
      @issues = []
    end

    def process
      doc = Nokogiri::XML(@document.file_xml)

      namespace = 'http://www.portalfiscal.inf.br/nfe'
      inf_nfe = doc.at_xpath('//nfe:infNFe', nfe: namespace)

      if inf_nfe
        ide = inf_nfe.at_xpath('nfe:ide', nfe: namespace)
        cUF = ide&.at_xpath('nfe:cUF', nfe: namespace)&.text&.strip
        cNF = ide&.at_xpath('nfe:cNF', nfe: namespace)&.text&.strip
        natOp = ide&.at_xpath('nfe:natOp', nfe: namespace)&.text&.strip
        mod = ide&.at_xpath('nfe:mod', nfe: namespace)&.text&.strip
        serie = ide&.at_xpath('nfe:serie', nfe: namespace)&.text&.strip
        nNF = ide&.at_xpath('nfe:nNF', nfe: namespace)&.text&.strip
        dhEmi = ide&.at_xpath('nfe:dhEmi', nfe: namespace)&.text&.strip
        tpNF = ide&.at_xpath('nfe:tpNF', nfe: namespace)&.text&.strip
        idDest = ide&.at_xpath('nfe:idDest', nfe: namespace)&.text&.strip
        cMunFG = ide&.at_xpath('nfe:cMunFG', nfe: namespace)&.text&.strip
        tpImp = ide&.at_xpath('nfe:tpImp', nfe: namespace)&.text&.strip
        tpEmis = ide&.at_xpath('nfe:tpEmis', nfe: namespace)&.text&.strip
        cDV = ide&.at_xpath('nfe:cDV', nfe: namespace)&.text&.strip
        tpAmb = ide&.at_xpath('nfe:tpAmb', nfe: namespace)&.text&.strip
        chave_acesso = inf_nfe&.attr('Id')&.sub(/^NFe/, '')&.strip

        emitente = inf_nfe.at_xpath('nfe:emit', nfe: namespace)
        nome_emitente = emitente&.at_xpath('nfe:xNome', nfe: namespace)&.text&.strip
        cnpj_emitente = emitente&.at_xpath('nfe:CNPJ', nfe: namespace)&.text&.strip
        endereco_emitente = emitente&.at_xpath('nfe:enderEmit', nfe: namespace)
        logradouro_emitente = endereco_emitente&.at_xpath('nfe:xLgr', nfe: namespace)&.text&.strip
        numero_emitente = endereco_emitente&.at_xpath('nfe:nro', nfe: namespace)&.text&.strip
        bairro_emitente = endereco_emitente&.at_xpath('nfe:xBairro', nfe: namespace)&.text&.strip
        municipio_emitente = endereco_emitente&.at_xpath('nfe:xMun', nfe: namespace)&.text&.strip
        uf_emitente = endereco_emitente&.at_xpath('nfe:UF', nfe: namespace)&.text&.strip
        cep_emitente = endereco_emitente&.at_xpath('nfe:CEP', nfe: namespace)&.text&.strip

        destinatario = inf_nfe.at_xpath('nfe:dest', nfe: namespace)
        nome_destinatario = destinatario&.at_xpath('nfe:xNome', nfe: namespace)&.text&.strip
        cnpj_destinatario = destinatario&.at_xpath('nfe:CNPJ', nfe: namespace)&.text&.strip
        endereco_destinatario = destinatario&.at_xpath('nfe:enderDest', nfe: namespace)
        logradouro_destinatario = endereco_destinatario&.at_xpath('nfe:xLgr', nfe: namespace)&.text&.strip
        numero_destinatario = endereco_destinatario&.at_xpath('nfe:nro', nfe: namespace)&.text&.strip
        bairro_destinatario = endereco_destinatario&.at_xpath('nfe:xBairro', nfe: namespace)&.text&.strip
        municipio_destinatario = endereco_destinatario&.at_xpath('nfe:xMun', nfe: namespace)&.text&.strip
        uf_destinatario = endereco_destinatario&.at_xpath('nfe:UF', nfe: namespace)&.text&.strip
        cep_destinatario = endereco_destinatario&.at_xpath('nfe:CEP', nfe: namespace)&.text&.strip

        produtos = []
        inf_nfe.xpath('nfe:det', nfe: namespace).each do |det|
          produto = {
            nome: det.at_xpath('nfe:prod/nfe:xProd', nfe: namespace)&.text&.strip,
            ncm: det.at_xpath('nfe:prod/nfe:NCM', nfe: namespace)&.text&.strip,
            cfop: det.at_xpath('nfe:prod/nfe:CFOP', nfe: namespace)&.text&.strip,
            unidade_comercializada: det.at_xpath('nfe:prod/nfe:uCom', nfe: namespace)&.text&.strip,
            quantidade_comercializada: det.at_xpath('nfe:prod/nfe:qCom', nfe: namespace)&.text&.strip,
            valor_unitario: det.at_xpath('nfe:prod/nfe:vUnCom', nfe: namespace)&.text&.strip,
            valor_total: det.at_xpath('nfe:prod/nfe:vProd', nfe: namespace)&.text&.strip
          }
          produtos << produto
        end

        taxas = []
        total = inf_nfe.at_xpath('nfe:total', nfe: namespace)
        icms_tot = total.at_xpath('nfe:ICMSTot', nfe: namespace)

        taxa = {
          valor_icms: icms_tot&.at_xpath('nfe:vICMS', nfe: namespace)&.text&.strip,
          valor_ipi: icms_tot&.at_xpath('nfe:vIPI', nfe: namespace)&.text&.strip,
          valor_pis: icms_tot&.at_xpath('nfe:vPIS', nfe: namespace)&.text&.strip,
          valor_cofins: icms_tot&.at_xpath('nfe:vCOFINS', nfe: namespace)&.text&.strip
        }
        taxas << taxa

        data = {
          cUF: cUF,
          cNF: cNF,
          natOp: natOp,
          mod: mod,
          serie: serie,
          nNF: nNF,
          dhEmi: dhEmi,
          tpNF: tpNF,
          idDest: idDest,
          cMunFG: cMunFG,
          tpImp: tpImp,
          tpEmis: tpEmis,
          cDV: cDV,
          tpAmb: tpAmb,
          chave_acesso: chave_acesso,
          nome_emitente: nome_emitente,
          cnpj_emitente: cnpj_emitente,
          logradouro_emitente: logradouro_emitente,
          numero_emitente: numero_emitente,
          bairro_emitente: bairro_emitente,
          municipio_emitente: municipio_emitente,
          uf_emitente: uf_emitente,
          cep_emitente: cep_emitente,
          nome_destinatario: nome_destinatario,
          cnpj_destinatario: cnpj_destinatario,
          logradouro_destinatario: logradouro_destinatario,
          numero_destinatario: numero_destinatario,
          bairro_destinatario: bairro_destinatario,
          municipio_destinatario: municipio_destinatario,
          uf_destinatario: uf_destinatario,
          cep_destinatario: cep_destinatario,
          produtos: produtos,
          taxas: taxas
        }

        document_process(data)
        products_process(data)
        taxas_process(data)
      end
    end

    private

    def document_process(data)
      @document.update(
        cUF: data[:cUF],
        cNF: data[:cNF],
        natOp: data[:natOp],
        mod: data[:mod],
        serie: data[:serie],
        nNF: data[:nNF],
        dhEmi: data[:dhEmi],
        tpNF: data[:tpNF],
        idDest: data[:idDest],
        cMunFG: data[:cMunFG],
        tpImp: data[:tpImp],
        tpEmis: data[:tpEmis],
        cDV: data[:cDV],
        tpAmb: data[:tpAmb],
        chave_acesso: data[:chave_acesso],
        nome_emitente: data[:nome_emitente],
        cnpj_emitente: data[:cnpj_emitente],
        logradouro_emitente: data[:logradouro_emitente],
        numero_emitente: data[:numero_emitente],
        bairro_emitente: data[:bairro_emitente],
        municipio_emitente: data[:municipio_emitente],
        uf_emitente: data[:uf_emitente],
        cep_emitente: data[:cep_emitente],
        nome_destinatario: data[:nome_destinatario],
        cnpj_destinatario: data[:cnpj_destinatario],
        logradouro_destinatario: data[:logradouro_destinatario],
        numero_destinatario: data[:numero_destinatario],
        bairro_destinatario: data[:bairro_destinatario],
        municipio_destinatario: data[:municipio_destinatario],
        uf_destinatario: data[:uf_destinatario],
        cep_destinatario: data[:cep_destinatario]
      )
    end

    def products_process(data)
      data[:produtos].each do |produto_data|
        existing_product = @document.operation_products.find_by(
          nome: produto_data[:nome],
          ncm: produto_data[:ncm],
          cfop: produto_data[:cfop]
        )
        unless existing_product
          @document.operation_products.create(produto_data)
        end
      end
    end

    def taxas_process(data)
      existing_taxa = @document.taxas.find_by(
        valor_icms: data[:taxas].first[:valor_icms],
        valor_ipi: data[:taxas].first[:valor_ipi],
        valor_pis: data[:taxas].first[:valor_pis],
        valor_cofins: data[:taxas].first[:valor_cofins]
      )
      unless existing_taxa
        @document.taxas.create(data[:taxas].first)
      end
    end
  end
end
