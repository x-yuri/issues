class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def ip
    render plain: "remote_ip: #{request.remote_ip}\n" \
      + "Host: #{request.headers["HTTP_HOST"]}\n" \
      + "X-Forwarded-For: #{request.headers["HTTP_X_FORWARDED_FOR"]}\n" \
      + "REMOTE_ADDR: #{request.headers["REMOTE_ADDR"]}\n" \
      + "---\n" \
      + (request.headers.map do |k,v|
        if k !~ /\A(rack|action_dispatch|puma|action_controller)\./
          "#{k}: #{v}\n"
        end
      end).compact.join('')
  end

  def assets_test
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
    picture = post_params[:picture]
    @post = Post.new(post_params
      .merge({picture: picture.original_filename}))

    respond_to do |format|
      if @post.save
        path = Rails.root.join('public', 'uploads', picture.original_filename)
        File.open(path, 'wb') do |file|
          file.write(picture.read)
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
      params.require(:post).permit(:name, :title, :content, :picture)
    end
end
