class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
      t.string   :title
      t.text     :body
    end
  end

  def self.down
    drop_table :posts
  end
end
