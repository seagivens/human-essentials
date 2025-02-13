module Types
  include Dry.Types()
end

module EventTypes
  class EventLineItem < Dry::Struct
    transform_keys(&:to_sym)
    attribute :quantity, Types::Integer # can be positive or negative
    attribute :item_id, Types::Integer
    attribute :item_value_in_cents, Types::Integer
    attribute :from_storage_location, Types::Integer.optional
    attribute :to_storage_location, Types::Integer.optional

    # @param line_item [LineItem]
    # @param from [Integer]
    # @param to [Integer]
    # @return [EventLineItem]
    def self.from_line_item(line_item, from: nil, to: nil)
      new(
        quantity: line_item.quantity,
        item_id: line_item.item_id,
        item_value_in_cents: line_item.item.value_in_cents,
        from_storage_location: from,
        to_storage_location: to
      )
    end

    # @param line_item [Array<LineItem>]
    # @param from [Integer]
    # @param to [Integer]
    # @return [Array<EventLineItem>]
    def self.from_line_items(line_items, from: nil, to: nil)
      line_items.map { |i| from_line_item(i, from: from, to: to) }
    end
  end
end
