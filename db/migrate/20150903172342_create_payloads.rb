class CreatePayloads < ActiveRecord::Migration
  def change
    create_table   :payloads do |payload|
      payload.text :url
    end
  end
end
