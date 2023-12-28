class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Posts: #{@posts.count}", template: "posts/index.html.erb"
      end
    end
  end

  # GET /posts/1 or /posts/1.json

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Post id: #{@post.id}", template: "posts/post.html.erb"   # Excluding ".pdf" extension.
      end
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
      if @post.save
        redirect_to @post,notice: "post was succesful created."
      else
        render :new, status: :unprocessable_entity
      end
  end


  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def sendmail
  #    WelcomeMailer.send_welcome_mail(@post).deliver_now
  #    head :no_content
  # end

  def sendmail
    # Increase the timeout (in seconds)
    Timeout.timeout(60) do
      WelcomeMailer.send_welcome_mail(@post).deliver_now
    end
    head :no_content
  end


  def send_post_pdf
    # @post = Post.find(params[:id])
    selected_layout = params[:layout]


    PostMailer.send_email(selected_layout).deliver_now
    # render nothing: true
    # redirect_to post_path(@post), notice: "Email send successfully"
  end

  # In posts_controller.rb
  # def send_post_pdf
  #   @post = Post.find(params[:id])
  #   # recipient_email = "mithilesh.goyal1@gmail.com"
  #   recipient_email = params[:recipient_email] # Assuming email address is provided in form params

  #   PostMailer.send_post_pdf(@post.id, recipient_email).deliver_now
  # end

  # def send_post_pdf
  #   @post = Post.find(params[:id])
  #   recipient_email = params[:recipient_email] # Example: Obtain from form

  #   PostMailer.send_post_pdf(@post.id, recipient_email).deliver_now
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
