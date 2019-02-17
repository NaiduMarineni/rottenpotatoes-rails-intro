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
    sort_id = params[:sort_id]
    if sort_id == nil
      @movies = Movie.all
    end
    
    @title_hilite = ''
    @date_hilite = ''
    if sort_id == 'title'
      @movies = Movie.ascorder(sort_id)
      @title_hilite = 'hilite'
    elsif sort_id == 'release_date'
      @movies = Movie.ascorder(sort_id)
      @date_hilite = 'hilite'
    end 
  end
  
  def get
    list = {}
    ratings.each do |key , value|
      list += key
    end
    
    redirect_to movies_path
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
