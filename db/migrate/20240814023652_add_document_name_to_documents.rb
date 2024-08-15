class AddDocumentNameToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :document_name, :string
  end
end