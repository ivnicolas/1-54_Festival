
class Scraper 

    RELATIVE_URL= "https://www.1-54.com/"

    def self.scrape_locations

    end 

    #Scrape Artist
    def self.scrape_artist 

        #scrapes artist at New York exhbit for name and url 
        html = open("https://1-54.com/new-york/artists/")
        doc = Nokogiri::HTML (html)
        #scrapes artist at New York exhbit for name and url 
        doc.css("ul.text-columns.column-5 ul li a").each do |artist|
            url = artist.attr("href")
            name = artist.text
            Artist.new(name,url)
        end 
        
    end 

       
    #Scrape Individual Artist 
    def self.scrape_individual_artist(artist)

        #Here is where you collect gallery, bio, and about message 
        html = open(artist.url)
        doc = Nokogiri::HTML(html)

        artist.gallery = doc.css("a.artist-representation").text
        artist.bio = doc.css("div.small-bio p").text
        artist.about_art =  doc.css("div section p").text.split("\n").join(" ")

    end 
    
end 

#bin/1-54_Festival