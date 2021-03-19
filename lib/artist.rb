class Artist
    #add attr_accessors 
    attr_accessor :url, :gallery, :bio, :about_art 
    attr_writer :name
    attr_reader :name

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

    def  name
        name_formatted=@name.split(", ")
        new_name= name_formatted.reverse.join(" ")
        new_name
    end 



end