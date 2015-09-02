class CreateClients < ActiveRecord::Migration
  def change
    create_table  :clients do |client|
      client.text :indentifier
      client.text :root_url

      client.timestamps null: false
    end
  end
end
