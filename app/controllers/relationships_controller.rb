class RelationshipsController < ApplicationController
  # l'utente deve essere loggato per follow/unfollow qualcuno
  before_filter :signed_in_user

  # respond to alle azioni con html o javascript
  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # senza javascript
    redirect_to @user
    #respond_with @user
    # Rails cerca file create.js.erb per rispondere all'azione con ajax
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # senza javascript
    redirect_to @user
    #respond_with @user
    # Rails cerca file destroy.js.erb file er rispondere all'azione con ajax
  end
end
