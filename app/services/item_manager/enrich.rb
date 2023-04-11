module ItemManager
  class Enrich < ApplicationService
    API_URL = "https://api.dandelion.eu/".freeze

    def initialize(item:)
      @item = item
    end

    attr_reader :item

    def call
      return if item.text.blank?
      return if item.enriched_at.present?

      item.update(sentiment: sentiment, enriched_at: Time.current)

      item
    end

    private

    def annotations
      payload = {
        text: item.text,
        token: Rails.application.credentials.dandelion.token,
        include: "types,categories",
        top_entities: 5
      }

      api(action: "nex", payload: payload).fetch("annotations", nil)
    end

    def sentiment
      payload = {
        text: item.text,
        token: Rails.application.credentials.dandelion.token
      }

      api(action: "sent", payload: payload).fetch("sentiment", nil)
    end

    def api(action:, payload: {})
      response =
        RestClient::Request.execute(
          method: :post,
          url: "#{API_URL}datatxt/#{action}/v1/?",
          payload: payload,
          timeout: 10
        )

      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      {}
    end
  end
end
