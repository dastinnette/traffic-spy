class CreateClientsTable < ActiveRecord::Migration
  def change
    create_table :clients do |client|
      client.text :indentifier
      client.text :rootUrl

      client.timestamps null: false
    end
  end
end
