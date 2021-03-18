class Artist
    #add attr_accessors 
    attr_accessor :name, :url, :gallery, :bio, :about_art 

    #collect all instances

    @@all = []

    #initialize with two arguments (name, url) an push into @@all
    def initialize(name,url)
        @name = name
        @url = url
        @@all << self

    end 

    #method that prints out all instances 

    def self.all
        @@all
    end 

end