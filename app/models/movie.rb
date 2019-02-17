class Movie < ActiveRecord::Base
    def self.ascorder(key)
        #puts @movies
        @movies = Movie.order(key)
        return @movies
    end
end
