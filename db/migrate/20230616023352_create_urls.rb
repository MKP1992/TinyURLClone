class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :slug, unique: true

      t.timestamps
    end
  end
end
