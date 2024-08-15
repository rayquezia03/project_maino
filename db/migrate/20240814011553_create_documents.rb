class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :cUF
      t.string :cNF
      t.string :natOp
      t.string :mod
      t.integer :serie
      t.integer :nNF
      t.datetime :dhEmi
      t.string :tpNF
      t.string :idDest
      t.string :cMunFG
      t.string :tpImp
      t.string :tpEmis
      t.string :cDV
      t.string :tpAmb
      t.string :chave_acesso
      t.string :nome_emitente
      t.string :cnpj_emitente
      t.string :logradouro_emitente
      t.integer :numero_emitente
      t.string :bairro_emitente
      t.string :municipio_emitente
      t.string :uf_emitente
      t.string :cep_emitente
      t.string :nome_destinatario
      t.string :cnpj_destinatario
      t.string :logradouro_destinatario
      t.integer :numero_destinatario
      t.string :bairro_destinatario
      t.string :municipio_destinatario
      t.string :uf_destinatario
      t.string :cep_destinatario

      t.timestamps
    end
  end
end
