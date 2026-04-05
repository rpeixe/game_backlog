class GamesController < ApplicationController
  allow_unauthenticated_access

  def search
    if params[:query].present?
      @games = CheapSharkClient.search(params[:query])

      if @games.empty?
        flash.now[:alert] = "No results found or service unavailable"
      end
    else
      @games = []
    end
  end
end
