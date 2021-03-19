class Galleries 
    attr_accessor :name, :url, :artists, :info

    @@all = []

    def initialize (name,url)
        @name= name
        @url= url
        @@all << self
    end 

    def self.all 
        @@all
    end 

    def artist_name
    self.artists.collect do |artist|
        artist.name
    end 
    #     Artist.all.select{|artist| artist.gallery==self }
    end 

end 