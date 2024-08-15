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
      
      ide = inf_nfe.at_xpath('nfe:ide', nfe: namespace)
      if inf_nfe
        cUF = ide&.at_xpath('nfe:cUF', nfe: namespace)&.text
        cNF = ide&.at_xpath('nfe:cNF', nfe: namespace)&.text
        natOp = ide&.at_xpath('nfe:natOp', nfe: namespace)&.text
        mod = ide&.at_xpath('nfe:mod', nfe: namespace)&.text
        serie = ide&.at_xpath('nfe:serie', nfe: namespace)&.text
        nNF = ide&.at_xpath('nfe:nNF', nfe: namespace)&.text
        dhEmi = ide&.at_xpath('nfe:dhEmi', nfe: namespace)&.text
        tpNF = ide&.at_xpath('nfe:tpNF', nfe: namespace)&.text
        idDest = ide&.at_xpath('nfe:idDest', nfe: namespace)&.text
        cMunFG = ide&.at_xpath('nfe:cMunFG', nfe: namespace)&.text
        tpImp = ide&.at_xpath('nfe:tpImp', nfe: namespace)&.text
        tpEmis = ide&.at_xpath('nfe:tpEmis', nfe: namespace)&.text
        cDV = ide&.at_xpath('nfe:cDV', nfe: namespace)&.text
        tpAmb = ide&.at_xpath('nfe:tpAmb', nfe: namespace)&.text
        chave_acesso = inf_nfe&.attr('Id')&.sub(/^NFe/, '')

        emitente = inf_nfe.at_xpath('nfe:emit', nfe: namespace)
        nome_emitente = emitente&.at_xpath('nfe:xNome', nfe: namespace)&.text
        cnpj_emitente = emitente&.at_xpath('nfe:CNPJ', nfe: namespace)&.text
        endereco_emitente = emitente&.at_xpath('nfe:enderEmit', nfe: namespace)
        logradouro_emitente = endereco_emitente&.at_xpath('nfe:xLgr', nfe: namespace)&.text
        numero_emitente = endereco_emitente&.at_xpath('nfe:nro', nfe: namespace)&.text
        bairro_emitente = endereco_emitente&.at_xpath('nfe:xBairro', nfe: namespace)&.text
        municipio_emitente = endereco_emitente&.at_xpath('nfe:xMun', nfe: namespace)&.text
        uf_emitente = endereco_emitente&.at_xpath('nfe:UF', nfe: namespace)&.text
        cep_emitente = endereco_emitente&.at_xpath('nfe:CEP', nfe: namespace)&.text

        destinatario = inf_nfe.at_xpath('nfe:dest', nfe: namespace)
        nome_destinatario = destinatario&.at_xpath('nfe:xNome', nfe: namespace)&.text
        cnpj_destinatario = destinatario&.at_xpath('nfe:CNPJ', nfe: namespace)&.text
        endereco_destinatario = destinatario&.at_xpath('nfe:enderDest', nfe: namespace)
        logradouro_destinatario = endereco_destinatario&.at_xpath('nfe:xLgr', nfe: namespace)&.text
        numero_destinatario = endereco_destinatario&.at_xpath('nfe:nro', nfe: namespace)&.text
        bairro_destinatario = endereco_destinatario&.at_xpath('nfe:xBairro', nfe: namespace)&.text
        municipio_destinatario = endereco_destinatario&.at_xpath('nfe:xMun', nfe: namespace)&.text
        uf_destinatario = endereco_destinatario&.at_xpath('nfe:UF', nfe: namespace)&.text
        cep_destinatario = endereco_destinatario&.at_xpath('nfe:CEP', nfe: namespace)&.text

        produtos = []
        inf_nfe.xpath('nfe:det', nfe: namespace).each do |det|
          produto = {
            nome: det.at_xpath('nfe:prod/nfe:xProd', nfe: namespace)&.text,
            ncm: det.at_xpath('nfe:prod/nfe:NCM', nfe: namespace)&.text,
            cfop: det.at_xpath('nfe:prod/nfe:CFOP', nfe: namespace)&.text,
            unidade_comercializada: det.at_xpath('nfe:prod/nfe:uCom', nfe: namespace)&.text,
            quantidade_comercializada: det.at_xpath('nfe:prod/nfe:qCom', nfe: namespace)&.text,
            valor_unitario: det.at_xpath('nfe:prod/nfe:vUnCom', nfe: namespace)&.text,
            valor_total: det.at_xpath('nfe:prod/nfe:vProd', nfe: namespace)&.text
          }
          produtos << produto
        end

        taxas = []
        total = inf_nfe.at_xpath('nfe:total', nfe: namespace)
        icms_tot = total.at_xpath('nfe:ICMSTot', nfe: namespace)

        taxa = {
          valor_icms: icms_tot&.at_xpath('nfe:vICMS', nfe: namespace)&.text,
          valor_ipi: icms_tot&.at_xpath('nfe:vIPI', nfe: namespace)&.text,
          valor_pis: icms_tot&.at_xpath('nfe:vPIS', nfe: namespace)&.text,
          valor_cofins: icms_tot&.at_xpath('nfe:vCOFINS', nfe: namespace)&.text
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
        @document.operation_products.create(produto_data)
      end
    end

    def taxas_process(data)
      data[:taxas].each do |taxa_data|
        @document.taxas.create(taxa_data)
      end
    end
  end
end
