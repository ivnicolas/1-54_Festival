require 'pry'
class Scraper 

    #Scrape Artist
    def self.scrape_artist 

        #scrapes artist at New York exhbit for name and url 
        html = open("https://www.1-54.com/new-york/artists/")
        doc = Nokogiri::HTML (html)
        #scrapes artist at New York exhbit for name and url 
        doc.css("ul.text-columns.column-5 ul li a").each do |artist|
            url = artist.attr("href")
            name = artist.text
            Artist.new(name,url)
        end 
        binding.pry
    end 

       
    #Scrape Individual Artist 
    def scrape_individual_artist
        #Here is where you collect gallery, bio, and about message 
    end 
    


    #**be mindful that artist name are displayed last name to first, so where in any of the lib classes ill you fix this so
    #it will be displayed first name last name? 
end 