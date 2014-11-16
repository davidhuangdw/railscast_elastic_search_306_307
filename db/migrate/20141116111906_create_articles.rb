class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :author, index: true
      t.string :name
      t.text :content
      t.datetime :published_at

      t.timestamps
    end
  end
end
