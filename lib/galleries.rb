class Galleries 
    attr_accessor :name, :url, :artists, :info

    #collect all instance
    @@all = []

    #initialize with two arguments (name, url) an push into @@all
    def initialize (name,url)
        @name= name
        @url= url
        @@all << self
    end 

    #Returns all instances
    def self.all 
        @@all
    end 

    #Gets the name of artist objects
    def artist_name
        self.artists.collect do |artist|
            artist.name
        end
    end 

end 