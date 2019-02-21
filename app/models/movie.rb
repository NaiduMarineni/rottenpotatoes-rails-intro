class Movie < ActiveRecord::Base
    def self.ascorder(key)
        #puts @movies
        @movies = Movie.order(key)
        return @movies
    end
    
    def self.listRatings
        list = Movie.uniq.pluck(:rating)
        return list
    end
    
    def self.get_Rated_Movies(list)
        Movie.where(rating: list)
    end
end
