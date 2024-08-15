class AddDocumentIdToTaxas < ActiveRecord::Migration[6.1]
  def change
    add_column :taxas, :document_id, :integer
    add_index :taxas, :document_id
  end
end
