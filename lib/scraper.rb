
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
       
        #Finds artists in Artist.all who are equal to the presenting artists in selected gallery and sets galley.artists to an array of those artist objects
        artists=[]
        doc.css("ul.presented-artists li").each do |presented_artist| 
            p_artist=presented_artist.text.split(", ").reverse.join(" ")
            Artist.all.detect do |artist|
                if artist.name == p_artist
                    artists <<artist
                end
            end 

        end 
        gallery.artists= artists 
        gallery.info= doc.css(".entry-content").css("p")[0].text

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

        html = open(artist.url)
        doc = Nokogiri::HTML(html)

        Galleries.all.detect do |gallery|
            if gallery.name == doc.css("a.artist-representation")[0].text
            artist.gallery = gallery
            end 
        end     
        
        artist.bio = doc.css("div.small-bio p").text
        artist.about_art =  doc.css(".entry-content").css("p")[0].text

    end 
    
end 



