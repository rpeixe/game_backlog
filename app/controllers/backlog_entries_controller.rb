class BacklogEntriesController < ApplicationController
  def index
    @entries = Current.user.backlog_entries.includes(:game)
    @entries.each do |entry|
      UpdateGamePriceJob.perform_later(entry.game.id)
    end
  end

  def create
    game = Game.find_or_create_by(external_id: params[:external_id]) do |game|
      game.name = params[:name]
      game.image_url = params[:image_url]
    end

    entry = Current.user.backlog_entries.build(game: game)

    if entry.save
      redirect_to games_search_path, notice: "Game added to backlog!"
    else
      redirect_to games_search_path, alert: "Game is already in backlog!"
    end
  end

  def update
    entry = Current.user.backlog_entries.find(params[:id])

    if entry.update(status: params[:status])
      redirect_to backlog_entries_path, notice: "Status updated!"
    else
      redirect_to backlog_entries_path, alert: "Failed to update status!"
    end
  end

  def destroy
    entry = Current.user.backlog_entries.find(params[:id])
    entry.destroy

    redirect_to backlog_entries_path, notice: "Game removed from backlog!"
  end
end
