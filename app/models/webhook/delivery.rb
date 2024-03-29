module Webhook
  module Delivery
    extend ActiveSupport::Concern

    def webhook_payload
      {}
    end

    def webhook_scope
      raise NotImplementedError
    end

    def deliver_webhook(action)
      event_name = "#{self.class.name.underscore}_#{action}"
      deliver_webhook_event(event_name, webhook_payload)
    end

    def deliver_webhook_event(event_name, payload)
      event = Webhook::Event.new(event_name, payload || {})
      Webhook::Callback
        .for_event(event_name)
        .each { |endpoint| endpoint.deliver(event) }
    end
  end
end
