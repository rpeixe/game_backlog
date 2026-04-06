class BacklogEntriesController < ApplicationController
  def create
    game = Game.find_or_create_by(external_id: params[:external_id]) do |game|
      game.name = params[:name]
      game.image_url = params[:image_url]
    end

    entry = Current.user.backlog_entries.build(game: game)

    if entry.save
      redirect_to games_search_path, notice: "Added to backlog!"
    else
      redirect_to games_search_path, alert: "Already in backlog!"
    end
  end
end
