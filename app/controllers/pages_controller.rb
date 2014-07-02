class PagesController < ApplicationController
  def home
    @post = current_user.posts.build if signed_in?
  end

  def about
  end

  def contact
  end

  def faq
  end

  def signup
  end

  def signin
  end
end