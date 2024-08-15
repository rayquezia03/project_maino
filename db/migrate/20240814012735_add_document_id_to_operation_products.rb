class AddDocumentIdToOperationProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :operation_products, :document_id, :integer
    add_index :operation_products, :document_id
  end
end
