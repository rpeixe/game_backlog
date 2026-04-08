module ApplicationHelper
  def store_info(store_id)
    @stores ||= CheapSharkClient.stores_by_id
    @stores[store_id]
  end
end
