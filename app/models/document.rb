class Document < ApplicationRecord
    validates :document_name, presence: true

    has_many :operation_products
    has_many :taxas
end
  