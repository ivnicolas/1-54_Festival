class CLI

    
    def run
        #puts welcome message with blurb about festival
        puts "Welcome to the 1-54 Artist Catalog"
        puts "1-54 is the first leading international art fair dedicated to contemporary art from Africa and its diaspora."
        Scraper.scrape_artist
        #list artist in right number and numerically (list artist method)
        list_artist
        #menue
        menue 
       
    end 
    
    def menue
        #Ask user to Choose Artist
        puts "Please select a number from the list present to learn more about an artist"
        user_input=gets.chomp
        #if not valid riase error and print error message
        if !user_input.to_i.between?(1,Artist.all.count)
            #Try to create and error message
            puts "Please choose a valid number"
            list_artist
            menue
        else 
            #if valid call artist_artist details method
            artist=Artist.all[user_input.to_i - 1]
            artist_details(artist)
        end 

    end 


    def list_artist
        #Instantiates though artist return a list of artist back in a numbered list and artist and listed alphabetically
        Artist.all.each.with_index(1) do |artist, i|
            puts "#{i}. #{artist.name}"
        end 
    end 

   
    
    def artist_details(artist)
       Scraper.scrape_individual_artist(artist)
        # Puts intro message 
        puts "Here is more details about #{artist.name}"
        # Puts gallery info
        puts "Representing Gallery: #{artist.gallery} "
        # Puts bio message
        puts "Artist Bio: #{artist.bio}"
        # Puts paragraph about artist's work 
        puts "About Artist's Work: #{artist.about_art}"
        #call closing method
    end 
   
    def closer
        puts "Would you like to continue "
        puts "1.) Continue exploring artist type "
        puts "2.) Exit application"
            #if they say continue run menue method
            #if they say exit, exit application

    end 

    


end 