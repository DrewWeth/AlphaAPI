class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  protect_from_forgery with: :null_session

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # render :json => @post
  end

  def up
    post = Post.find(params["id"])
    post.ups += 1
    if post.ups > post.downs
      post.radius += 0.5
    end
    post.save
    render :json => post
  end

  ## needs parameters
  def get_nearby
    # radius = params["radius"].to_f || 5.0
    posts = Post.where("created_at > ?", 1.days.ago)
    matches = []
    posts.each do |p|
      if Geocoder::Calculations.distance_between([params["latitude"], params["longitude"]] , [p.latitude, p.longitude]) < p.radius
        matches << p
      end
    end
    render :json => matches.sort{|a,b| b.updated_at <=> a.updated_at} ## Can push off to (1) database or (2) iphone for efficiency
  end

  def down
    post = Post.find(params["id"])
    post.downs += 1
    if post.ups < post.downs
      post.radius -= 0.2
    end
    post.save
    render :json => post
  end

  def viewed
    post = Post.find(params["id"])
    post.views += 1
    post.radius += 0.25
    post.save
    render :json => post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /submit
  def submit
    if params["device_id"] != nil and device = Device.find(params["device_id"])
      if params["auth_key"] and params["auth_key"] == device.auth_key
        if params["latitude"] != nil and params["longitude"] != nil
          @post = Post.new
          @post.content = params["content"]
          @post.latitude = params["latitude"]
          @post.longitude = params["longitude"]
          @post.device_id = params["device_id"]
          if @post.save
            render :json => @post
          end
        else
          render :json => '{"status": "failed","reason": "need latitude and longitude position"}'
        end
      else
        render :json => '{"status": "failed","reason": "invalid auth_key"}'
      end
    else
      render :json => '{"status": "failed","reason": "invalid device"}'
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :latitude, :longitude, :views, :ups, :downs, :radius, :device_id)
    end
end
