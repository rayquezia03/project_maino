class AddFieldsToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :file_xml, :string
    add_column :documents, :content_type, :string
  end
end
