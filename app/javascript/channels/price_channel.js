import consumer from "channels/consumer"

consumer.subscriptions.create("PriceChannel", {
  received(data) {
    updatePrice(data)
  }
});

function updatePrice(data, retries = 5) {
  const element = document.querySelector(
    `[data-game-id='${data.game_id}']`
  )

  if (element) {
    element.innerText = `$${data.price}`
  } else if (retries > 0) {
    setTimeout(() => updatePrice(data, retries - 1), 200)
  }
}
