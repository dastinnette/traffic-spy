class AddHashColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :hashed, :string
  end
end
