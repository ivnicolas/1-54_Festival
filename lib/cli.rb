class CLI

    def run
        #puts welcome message with blurb about festival
        puts ""
        puts "Welcome to the 1-54 Artist Catalog"
        puts "1-54 is the first leading international art fair dedicated to contemporary art from Africa and its diaspora."
        main_menue

    end 
    
    def main_menue
       #ask user to chose how they would like to explore the festival 
       puts ""
       puts "Type (A) to Explore Galleries OR (B) to Explore Artist"
       user_input=gets.chomp
        if user_input.downcase == "a"
            Scraper.scrape_exhibitors
            list_gallery
            gallery_menue
        elsif user_input.downcase == "b"
            Scraper.scrape_artist
            list_artist
            artist_menue
        else 
            puts "Invalid entry. Please try again"
            main_menue
        end 

       #prints out the correct list based on selection
    end 

## FOR ARTIST ## 
    def artist_menue
        #Ask user to Choose Artist
        puts "Please select a number from the list present to learn more about an artist"
        user_input=gets.chomp
        #if not valid riase error and print error message
        if !user_input.to_i.between?(1,Artist.all.count)
            #Try to create and error message
            puts "Please choose a valid number"
            list_artist
            artist_menue
        else 
            #if valid call artist_artist details method
            artist=Artist.all[user_input.to_i - 1]
            artist_details(artist)
        end 

        closer

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
        puts ""
        puts "Here is more details about #{artist.name}."
        puts ""
        # Puts gallery info
        puts "Representing Gallery: #{artist.gallery} "
        puts ""
        # Puts bio message
        puts "Artist Bio: #{artist.bio}"
        puts ""
        # Puts paragraph about artist's work 
        puts "About Artist's Work: #{artist.about_art}"
        puts ""

    end 

    ## FOR GALLERIES ##
    def gallery_menue
        #Ask user to Choose Gallery
        puts "Please select a number from the list present to learn more about a gallery"
        user_input=gets.chomp
        #if not valid riase error and print error message
        if !user_input.to_i.between?(1,Galleries.all.count)
            #Try to create and error message
            puts "Please choose a valid number"
            list_gallery
            gallery_menue
        else 
            #if valid call artist_artist details method
            gallery=Galleries.all[user_input.to_i - 1]
            gallery_details(gallery)
        end 

        closer

    end 

    def list_gallery
        #Instantiates though Exhibitors return a list of galleries back in a numbered list and artist and listed alphabetically
        Galleries.all.each.with_index(1) do |gallery, i|
            puts "#{i}. #{gallery.name}"
        end 
    end 

    def gallery_details(gallery)
        Scraper.scrape_idv_gallery(gallery) 
         # Puts intro message 
         puts ""
         puts "Here is more details about #{gallery.name}."
         puts ""
         # Puts gallery info
         puts "Presenting Artist: #{gallery.artists} "
         puts ""
    end 


    def closer
        puts "Would you like to continue? Enter Y or N"
        input=gets.chomp
         #if they say Y run menue method
            if input.downcase == "y"
                list_artist
                menue 
         #if they say N exit application
            elsif input.downcase == "n"
                puts ""
                puts "Thank you for exploring!"
                puts ""
         #if input is invalid raise error
            else 
                puts "Please enter a valid "
                closer
        end 
    end 

end 