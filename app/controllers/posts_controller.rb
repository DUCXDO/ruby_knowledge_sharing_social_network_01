class PostsController < ApplicationController
  before_action :list_visibility, only: %i(new create)
  before_action :logged_in_user, only: %i(new create)
  before_action :search_post, only: %i(show)
  before_action :featured_post_list, only: %i(show)

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    @post.post!

    if @post.save
      tagging
      flash[:success] = t ".create_post_success"
      redirect_to home_path
    else
      flash.now[:danger] = t ".create_post_fail"
      render :new
    end
  end

  def show; end

  private

  def list_visibility
    @list = Post.visibilities
                .map{|h, _k| [I18n.t(Settings.post_i18n_path + h), h]}
  end

  def post_params
    params.require(:post).permit :title, :content, :visibility
  end

  def tag_params
    params[:post][:tag]
  end

  def tagging
    tag_params.split(",").each do |tag|
      @tag = Tag.new name: tag

      if @tag.save
        @used_tag = @post.used_tags.build
        @used_tag.tag_id = @tag.id
        @used_tag.save
      else
        flash.now[:danger] = t(".create_tag_fail") + @tag.name
      end
    end
  end

  def search_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = t "post_not_found"
    redirect_to home_path
  end

  def featured_post_list
    @featured_post_list = Post.first 3
  end
end
