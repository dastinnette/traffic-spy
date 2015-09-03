class CreateSources < ActiveRecord::Migration
  def change
    create_table  :sources do |source|
      source.text :identifier
      source.text :root_url

      source.timestamps null: false
    end
  end
end
