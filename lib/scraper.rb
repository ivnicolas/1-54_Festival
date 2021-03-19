
class Scraper 


    #Scrape Galleries
    def self.scrape_galleries
        html = open("https://www.1-54.com/new-york/exhibitors/")
        doc = Nokogiri::HTML (html)
        doc.css("ul.text-columns.column-4 li a").each do |gallery|
            url = gallery.attr("href")
            name = gallery.text
            Galleries.new(name,url)
        end 

    end 

    #Screap Individual Gallery
    def self.scrape_idv_gallery(gallery) 
        html = open(gallery.url)
        doc = Nokogiri::HTML(html)
       
        #interate through artist,push into array,
        artists=[]
        doc.css("ul.presented-artists li").each do |presented_artist| 
            p_artist=presented_artist.text.split(", ").reverse.join(" ")
            Artist.all.detect do |artist|
                if artist.name == p_artist
                    artists <<artist
                end
            end 
        
        end 
        # binding.pry

        #Set gallery.artist to an array of artist instances
        gallery.artists= artists
        
        #get gallery info
        gallery.info= doc.css("div section p").text

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



