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
end 