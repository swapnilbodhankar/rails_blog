class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    if params[:search].present?
      @blogs = Blog.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
    elsif params[:category_id].present?
      @blogs = Blog.where(category_id: params[:category_id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    else
      @blogs = Blog.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    end
    respond_to do |format|
      format.js
      format.html 
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
     @blog_comments = @blog.comments.order("created_at desc")
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @categories = Category.select("id,name")
  end

  # GET /blogs/1/edit
  def edit
    @categories = Category.select("id,name")
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blogs_url, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blogs_url, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def sort
    case params["sort_option"]
    when "DatePublished_Asc"
      @blogs = Blog.order("created_at ASC")
    when "DatePublished_Desc"
      @blogs = Blog.order("created_at DESC")
    when "Popular"
      @blogs = Blog.all
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  def post_comment
    @blog = Blog.find(params[:blog_id])
    @blog_comment = Comment.add_comment(params[:comment],params[:name],@blog)
    @blog_comments = @blog.comments.order("created_at desc")
    respond_to do |format|
      format.js
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :description,:author,:category_id)
    end
end
