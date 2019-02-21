class MoviesController < ApplicationController
  helper:all
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.listRatings
    
    if params[:ratings]
      @def_ratings = params[:ratings]
    elsif session[:ratings]
      @def_ratings = session[:ratings]
    else
      @def_ratings = Hash[@all_ratings.collect{|item| ["item", '1']}]
      #@all_ratings.each do |rating| #initial default values
      #  (@def_ratings ||= { })[rating] = 1
      #end
    end
    @movies = Movie.get_Rated_Movies(@def_ratings.keys())
    
    if params[:sort_id] != nil
      @title_hilite = ''
      @date_hilite = ''
      if params[:sort_id] == 'title'
        @movies = Movie.ascorder('title')
        @title_hilite = 'hilite'
      elsif params[:sort_id] == 'release_date'
        @movies = Movie.ascorder('release_date')
        @date_hilite = 'hilite'
      end
    end
    
    session[:ratings] = @def_ratings
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
