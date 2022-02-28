class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @sort = params[:sort] 
    # @movies = Movie.all.order(@sort)
    # @rating_checks = @ratings
    # @all_ratings = Movie.ratings
    # @sort = params[:sort]||session[:sort]
    # # #session[:ratings] = session[:ratings]||{'G'=>'','PG'=>'','PG-13'=>'','R'=>''}
    # # @t_param = params[:ratings]||session[:ratings]
    # # session[:sort] = @sort
    # # session[:ratings] = @t_param
    # # @movies = Movie.where(rating: session[:ratings].keys).order(session[:sort])
    # # # if (params[:sort].nil? and !(session[:sort].nil?) or (params[:ratings].nil?))
    # # #   flash.keep
    # # end
    # if params.key?(:sort)
    #   session[:sort] = params[:sort]
    # end
    # if session[:sort] == 'title'
    #   @movies = @movies.order(:title)
    # elsif session[:sort] == 'release_date'
    #   @movies = @movies.order(:release_date)
    # end
    
    # if params.key?(:ratings)
    #   session[:ratings] = params[:ratings].keys
    # end
    # if session.key?(:ratings)
    #   @rating_checks = session[:ratings]
    #   puts @rating_checks
    #   @movies = @movies.where(rating: @ratings_checks)
    #   puts @movies
    # end
    @movies = Movie.all
    @all_ratings = Movie.obtain_ratings


    # if params.key?(:sort_by)
    #   session[:sort_by] = params[:sort_by]
    # end

    # if session[:sort_by] == 'title'
    #   @movies = @movies.order(:title)
    # elsif session[:sort_by] == 'release_date'
    #   @movies = @movies.order(:release_date)
    # end
      
    @sort = params[:sort]||session[:sort]
    
    if params.key?(:sort)
      session[:sort] = params[:sort]
    end
    if session[:sort] == 'title'
      @movies = @movies.order(:title)
    elsif session[:sort] == 'release_date'
      @movies = @movies.order(:release_date)
    end
    # #session[:ratings] = session[:ratings]||{'G'=>'','PG'=>'','PG-13'=>'','R'=>''}
    # @t_param = params[:ratings]||session[:ratings]
    # session[:sort] = @sort
    # session[:ratings] = @t_param
    # @movies = Movie.where(rating: session[:ratings].keys).order(session[:sort])
    # # if (params[:sort].nil? and !(session[:sort].nil?) or (params[:ratings].nil?))
    # #   flash.keep
    # end

    if params.key?(:ratings)
      session[:ratings] = params[:ratings].keys
    end
    if session.key?(:ratings)
      @ratings_checks = session[:ratings]
      @movies = @movies.where(rating: @ratings_checks)
    end
    
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

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
