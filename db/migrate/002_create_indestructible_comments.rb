class CreateIndestructibleComments < ActiveRecord::Migration
  def self.up
    create_table :indestructible_comments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
      t.integer  :post_id
      t.text     :body
    end
  end

  def self.down
    drop_table :comments
  end
end
