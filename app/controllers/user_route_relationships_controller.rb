class UserRouteRelationshipsController < ApplicationController
  # l'utente deve essere loggato per follow/unfollow un itinerario
  before_filter :signed_in_user

  def create
    @route = Route.find(params[:user_route_relationship][:route_id])
    current_user.r_follow!(@route)
    # senza javascript:
    redirect_to @route
  end

  def destroy
    @route = UserRouteRelationship.find(params[:id]).route
    current_user.r_unfollow!(@route)
    # senza javascript:
    redirect_to @route
  end
end
