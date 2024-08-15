class FiltersService
    def self.nome_emitente_options
      Document.pluck(:nome_emitente).uniq
    end
  
    def self.cnpj_emitente_options
      Document.pluck(:cnpj_emitente).uniq
    end
  
    def self.nome_destinatario_options
      Document.pluck(:nome_destinatario).uniq
    end

    def self.uf_emitente_options
      Document.pluck(:uf_emitente).uniq
    end 
  
    def self.product_options
      OperationProduct.pluck(:nome).uniq
    end
end