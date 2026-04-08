class PriceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "prices"
  end
end
