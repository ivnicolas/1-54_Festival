class CLI

    def run
        #puts welcome message with blurb about festival
        puts ""
        puts "Welcome to the 1-54 Artist Catalog"
        puts "1-54 is the first leading international art fair dedicated to contemporary art from Africa and its diaspora."
        puts "Loading Catalog..."
        Scraper.scrape_galleries
        Scraper.scrape_artist
        main_menu

    end 
    
    def main_menu
       #ask user to chose how they would like to explore the festival 
       puts ""
       puts "Type (A) to Explore Galleries OR (B) to Explore Artist"
       user_input=gets.chomp
        if user_input.downcase == "a"
            # Scraper.scrape_exhibitors
            list_gallery
            gallery_menu
        elsif user_input.downcase == "b"
            # Scraper.scrape_artist
            list_artist
            artist_menu
        else 
            puts "Invalid entry. Please try again"
            main_menu
        end 

       #prints out the correct list based on selection
    end 

## FOR ARTIST ## 
    def artist_menu
        #Ask user to Choose Artist
        puts "Please select a number from the list present to learn more about an artist"
        user_input=gets.chomp
        #if not valid riase error and print error message
        if !user_input.to_i.between?(1,Artist.all.count)
            #Try to create and error message
            puts "Please choose a valid number"
            list_artist
            artist_menu
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
        puts ""
        puts "Here is more details about #{artist.name}."
        puts ""
        # Puts gallery info
        puts "Representing Gallery: #{artist.gallery.name} "
        puts ""
        # Puts bio message
        puts "Artist Bio: #{artist.bio}"
        puts ""
        # Puts paragraph about artist's work 
        puts "About the Artist : #{artist.about_art}"
        puts ""

        puts "Would you like to learn more about #{artist.gallery.name}? Y or N"
        input=gets.chomp

        if input.downcase == "y"
            gallery_details(artist.gallery)
        elsif input.downcase == "n"
            closer
        else 
            "I did not recognize your selection. Please try again"
        end 

    end 

    ## FOR GALLERIES ##
    def gallery_menu
        #Ask user to Choose Gallery
        puts "Please select a number from the list present to learn more about a gallery"
        user_input=gets.chomp
        #if not valid riase error and print error message
        if !user_input.to_i.between?(1,Galleries.all.count)
            #Try to create and error message
            puts "Please choose a valid number"
            list_gallery
            gallery_menu
        else 
            #if valid call artist_artist details method
            gallery=Galleries.all[user_input.to_i - 1]
            gallery_details(gallery)
        end 


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
         # Puts artist info
         puts "Presenting Artist(s): #{gallery.artist_name.join(" | ")} "
         puts ""
         #Puts Gallery Info
         puts "About the Gallery: #{gallery.info} "
         puts ""

         #Explore Presenting Artist?
         puts "Would you like to explore #{gallery.name}'s Presenting Artist(s)? Y OR N"
         input=gets.chomp

         if input.downcase == "y"
            list_presenting_artists(gallery)
            presenting_artist_menu(gallery)
            continue_exploring_presenting_artists(gallery)
            
         elsif input.downcase == "n"
            closer
         else 
            puts "I did not recognize your selection. Please try again"
         end

         
    end 

    def list_presenting_artists(gallery)
        gallery.artist_name.each.with_index(1) do |artist, i|
            puts "#{i}. #{artist}"
        end 
    end 

    def presenting_artist_menu(gallery)

        puts "Please select an artist"
        user_input=gets.chomp
        if !user_input.to_i.between?(1,gallery.artists.count)
            puts "Invalid entry. Please try again"
            list_presenting_artists(gallery)
            presenting_artist_menu(gallery) 
        else 
            artist= gallery.artists[user_input.to_i - 1]
            artist_details(artist)
        end

    end

    def continue_exploring_presenting_artists(gallery)
        puts "Would you like to keep exploring #{gallery.name}'s Presenting Artist(s)? Y or N"
        input=gets.chomp
        if input.downcase == "y"
            list_presenting_artists(gallery)
            presenting_artist_menu(gallery)
        elsif input.downcase == "n"
            closer
        else 
            puts "Invalid entry. Please try again"
        end 
    end 

    def closer
        puts "How would you like to proceed? Please Type Number to Select."
        puts " (1) Explore all Artist"
        puts " (2) Explore all Galleries"
        puts " (3) Exit"

        input=gets.chomp
        #if they say 1 display All Artist
            if input == "1"
                list_artist
                artist_menu
        #if they say 2 display all Galleries
            elsif input == "2"
                list_gallery
                gallery_menu
        #if they say 3 exit application
            elsif input == "3"
                puts ""
                puts "Thank you for checking out the 1-54 Catalog. Please visit www.1-54.com to learn more!"
                puts ""
         #if input is invalid raise error
            else 
                puts "Please enter a valid "
                closer
            end 
    end 

end 
