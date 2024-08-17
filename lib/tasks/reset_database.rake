namespace :reset_database do
    task call: :environment do
        Document.delete_all
        OperationProduct.delete_all
        Taxa.delete_all  
  
      puts '-------------------- RESETED DB -------------------------'
    end
end