class GamesController < ApplicationController
  allow_unauthenticated_access

  def search
    if params[:query].present?
      @games = CheapSharkClient.search(params[:query])
    else
      @games = []
    end
  end
end
