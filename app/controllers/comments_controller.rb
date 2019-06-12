class CommentsController < ApplicationController
  protect_from_forgery except: :create

  def create
    @comment = Comment.create(text: comments_params[:text], tweet_id: comments_params[:tweet_id], user_id: current_user.id)
    # redirect_to "/tweets/#{comment.tweet.id}"     # コメントと結びつくツイートの詳細画面に遷移
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:tweet_id])  }
      format.json
    end
  end

  private
  def comments_params
    params.permit(:text, :tweet_id)
  end
end
