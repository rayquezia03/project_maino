namespace :task_fix_formatting_errors do
    task call: :environment do
  
      Document.find_each do |document|
        puts '---------------------------------'
        p "Cleanning doc: #{document.id}"
        document.attributes.each do |key, value|
          if value.is_a?(String)
            cleaned_value = value.strip
            document.update_column(key, cleaned_value) if cleaned_value != value
          end
        end
      end
  
      OperationProduct.find_each do |operation_product|
        p "Cleanning product: #{operation_product.id}"
        operation_product.attributes.each do |key, value|
          if value.is_a?(String)
            cleaned_value = value.strip
            operation_product.update_column(key, cleaned_value) if cleaned_value != value
          end
        end
      end
  
      puts '-------------------- COMPLETED FIX FORMATTING STRINGS IN XML -------------------------'
    end
end