module CasperPets
  class ReviewCollection
    include Enumerable
    extend Forwardable

    class << self
      def new_from_website
        reviews = new
        page_number = 0
        last_page = true

        loop do
          response = HTTP.get "https://casper.com/reviews?page=#{page_number += 1}"
          elements = Nokogiri::HTML(response.to_s).css("div.review")
          break if elements.empty?
          elements.each do |element|
            reviews << CasperPets::Review.new_from_html(element)
          end
        end

        first_names = reviews.collect(&:first_name)

        genders = Gendered::NameList.new(first_names).guess!

        reviews.each_with_index do |review, index|
          review.gender = genders[index]
        end

        reviews
      end
    end

    def initialize
      @reviews = []
    end

    def_delegators :@reviews, :<<

    def each
      @reviews.each do |review|
        yield review
      end
    end

    def to_csv
      columns = ["name","gender","location","age","rating","partner?","pet?","dog?","cat?"]
      CSV.generate do |csv|
        csv << columns
        each do |review|
          csv << columns.collect { |column| review.send column }
        end
      end
    end

  end
end
