class CreateNewResolutionTable < ActiveRecord::Migration
  def change
    create_table :resolutions do |resolution|
      resolution.text :height
      resolution.text :width

      resolution.timestamps null: false
    end
    add_column :payloads, :resolution_id, :integer
  end
end
