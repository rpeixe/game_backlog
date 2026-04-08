import consumer from "channels/consumer"

consumer.subscriptions.create("PriceChannel", {
  received(data) {
    const container = document.querySelector(
      `[data-deal='${data.game_id}']`
    )

    if (container) {
      container.innerHTML = `
        <a href="https://www.cheapshark.com/redirect?dealID=${data.deal_id}"
          target="_blank"
          class="mt-2 inline-flex items-center gap-1 text-xs text-blue-600 hover:text-blue-800 hover:underline transition">

          <span class="text-gray-700">Best deal:</span>
          <span class="font-semibold text-green-600">$${data.price}</span>
          <span class="text-gray-500">on</span>
          <img src="https://www.cheapshark.com${data.store_logo}" class="w-4 h-4">
          <span>${data.store_name}</span>
          <span>→</span>
        </a>
      `
    }
  }
})

