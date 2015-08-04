module CasperPets
  class Review

    attr_accessor :partner, :cat, :dog, :name, :age, :location, :rating, :gender

    class << self
      def new_from_html(html)
        element = case html
        when Nokogiri::XML::Element then html
        when String then Nokogiri::HTML(html)
        end

        new.tap do |review|
          review.partner = element.css("div[class*='partner']").any?
          review.dog = element.css("div[class*='dog']").any?
          review.cat = element.css("div[class*='cat']").any?
          review.name = element.at_css("div.name").text

          info = element.at_css("div.info").text
          review.location = info.split("|")[0].strip
          review.age = info.split("|")[1].strip.to_i

          review.rating = element.css("div.cs-icon-star-blue").count
        end
      end
    end

    def initialize
      @partner = false
      @cat = false
      @dog = false
    end

    def dog?
      !!dog
    end

    def cat?
      !!cat
    end

    def partner?
      !!partner
    end

    def pet?
      dog || cat
    end

    def gender
      @gender || Gendered::Name.new(first_name)
    end

    def first_name
      name.split(/\s/).first.to_s
    end

  end
end
