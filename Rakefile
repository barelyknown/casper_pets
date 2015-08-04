require "casper_pets"
require "bundler/gem_tasks"

task :export do
  reviews = CasperPets::ReviewCollection.new_from_website

  export_file_name = "casper_reviews_#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"

  File.open(File.expand_path("../data/export/#{export_file_name}", __FILE__), "w") do |f|
    f.write reviews.to_csv
  end
end
