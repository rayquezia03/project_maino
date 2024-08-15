class CreateOperationProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :operation_products do |t|
      t.string :nome
      t.string :ncm
      t.string :cfop
      t.string :unidade_comercializada
      t.decimal :quantidade_comercializada, precision: 10, scale: 2
      t.decimal :valor_unitario, precision: 10, scale: 2
      t.decimal :valor_total, precision: 10, scale: 2

      t.timestamps
    end
  end
end