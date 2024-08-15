class CreateTaxas < ActiveRecord::Migration[6.1]
  def change
    create_table :taxas do |t|
      t.decimal :valor_icms, precision: 10, scale: 2
      t.decimal :valor_ipi, precision: 10, scale: 2
      t.decimal :valor_pis, precision: 10, scale: 2
      t.decimal :valor_cofins, precision: 10, scale: 2

      t.timestamps
    end
  end
end
