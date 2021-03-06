class CLI

#DESCRIBE
    def run
        #puts welcome message with blurb about festival
        puts ""
        puts "Welcome to the 1-54 Artist Catalog".black.on_magenta
        puts "1-54 is the first leading international art fair dedicated to contemporary art from Africa and its diaspora.".italic
        puts ""
        puts "Loading Catalog...".red
        Scraper.scrape_galleries
        Scraper.scrape_artist
        main_menu

    end 
#DESCRIBE 
    def main_menu
       #ask user to chose how they would like to explore the festival 
       puts ""
       puts "Type (A) to Explore Galleries OR (B) to Explore Artist".black.on_white
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
            puts "Invalid entry. Please try again".black.on_white
            main_menu
        end 

       #prints out the correct list based on selection
    end 

#ARTIST:Asks User to make a selection from list, checks validity of selecetion, and, if valid, calls on artist_details 
    def artist_menu
    
        puts "Please select a number from the list present to learn more about an artist".black.on_white
        user_input=gets.chomp
        
        if !user_input.to_i.between?(1,Artist.all.count)
            puts "Please choose a valid number".black.on_white
            list_artist
            artist_menu
        else 
            artist=Artist.all[user_input.to_i - 1]
            artist_details(artist)
            continue_exploring_gallery(artist)
        end 

    end 
#ARTIST:Iterates through Artist.all and returns a numbered list 
    def list_artist
        Artist.all.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
    end 
#ARTIST: Puts out details of selected artist, which includes  gallery, bio, and artist statement of selected artist. 
    def artist_details(artist)
       Scraper.scrape_individual_artist(artist) 

        puts ""
        puts "Here are more details about #{artist.name.bold}.".black.on_light_white
        puts ""
        puts "Representing Gallery: #{artist.gallery.name} "
        puts ""
        puts "Artist Bio: #{artist.bio}"
        puts ""
        puts "About the Artist : #{artist.about_art}"
        puts ""

    end 
#ARTIST Continue Exploring Gallery Details
    def continue_exploring_gallery(artist)

        puts "Would you like to learn more about #{artist.gallery.name.bold}? Y or N".black.on_white
        input=gets.chomp

        if input.downcase == "y"
            gallery_details(artist.gallery)
            explore_gallery(artist.gallery)
        elsif input.downcase == "n"
            closer
        else 
            #THIS ONE 
            puts "I did not recognize your selection. Please try again".black.on_white
            continue_exploring_gallery(artist)

        end 
    end 
#GALLERY: Asks User to make a selection from gallery list, checks validility of selection, and, if valid, calls on gallery_details
    def gallery_menu

        puts "Please select a number from the list present to learn more about a gallery".black.on_white
        user_input=gets.chomp

        if !user_input.to_i.between?(1,Galleries.all.count)
            puts "Please choose a valid number".black.on_white
            list_gallery
            gallery_menu
        else 
            gallery=Galleries.all[user_input.to_i - 1]
            gallery_details(gallery)
            explore_gallery(gallery)
        end 

    end 
#GALLERY:Iterates through Gallerie.all and returns a numbered list
    def list_gallery
        Galleries.all.each.with_index(1) { |gallery, i| puts "#{i}. #{gallery.name}"}
    end 
#GALLERY: Puts details of selected gallery, which includes Presenting artist and gallery info. 
    def gallery_details(gallery)
        Scraper.scrape_idv_gallery(gallery) 
    
         puts ""
         puts "Here is more details about #{gallery.name.bold}.".black.on_white
         puts ""
         puts "Presenting Artist(s): #{gallery.artist_name.join(" | ")} "
         puts ""
         puts "About the Gallery: #{gallery.info} "
         puts ""
  
    end 
#GALLERY:Takes in argument of gallery and returns a number list of the presented artist at that gallery. 
    def list_presenting_artists(gallery)
        gallery.artist_name.each.with_index(1) {|artist, i|   puts "#{i}. #{artist}"}
    end 
#GALLERY:Take in argument of gallery, ask user to choose an artist who is being presented by that gallery, and if selection is valid, calls on artist_details taking argument of selected artist
    def presenting_artist_menu(gallery)

        puts "Please select an artist".black.on_white
        user_input=gets.chomp
        if !user_input.to_i.between?(1,gallery.artists.count)
            puts "Invalid entry. Please try again".black.on_white
            list_presenting_artists(gallery)
            presenting_artist_menu(gallery) 
        else 
            artist= gallery.artists[user_input.to_i - 1]
            artist_details(artist)
            continue_exploring_presenting_artists(gallery)
        end

    end
#GALLERY : Describe
    def explore_gallery(gallery)
         #Explore Presenting Artist?
         puts "Would you like to explore #{gallery.name.bold}'s Presenting Artist(s)? Y OR N".black.on_white
         input=gets.chomp

         if input.downcase == "y"
            list_presenting_artists(gallery)
            presenting_artist_menu(gallery)
            
         elsif input.downcase == "n"
            closer
         else 
            puts "I did not recognize your selection. Please try again".black.on_white
            puts ""
            explore_gallery(gallery)
         end
    end 
#GALLERY:Takes in argument of gallery. Asks user if they want to continue exploring artist at this gallery or explor other options
    def continue_exploring_presenting_artists(gallery)
        puts "Would you like to keep exploring #{gallery.name.bold}'s Presenting Artist(s)? Y or N".black.on_white
        input=gets.chomp
        if input.downcase == "y"
            list_presenting_artists(gallery)
            presenting_artist_menu(gallery)
        elsif input.downcase == "n"
            closer
        else 
            puts "Invalid entry. Please try again".black.on_white
            continue_exploring_presenting_artists(gallery)
        end 
    end 

#Ask user if they want to explore all artist, all galleries, or exit. 
    def closer
        puts "How would you like to proceed? Please Type Number to Select.".black.on_white
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
                puts "Thank you for checking out the 1-54 Catalog. Please visit www.1-54.com to learn more!".white.on_magenta
                puts ""
         #if input is invalid raise error
            else 
                puts "Please enter a valid ".black.on_white
                closer
            end 
    end 
end 
