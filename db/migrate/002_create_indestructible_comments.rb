class CreateIndestructibleComments < ActiveRecord::Migration
  def self.up
    create_table :indestructible_comments do |t|
      t.datetime :created_at
      t.datetime :created_by
      t.datetime :updated_at
      t.datetime :updated_by
      t.datetime :destroyed_at
      t.datetime :destroyed_by
      t.integer  :post_id
      t.text     :body
    end
  end

  def self.down
    drop_table :indestructible_comments
  end
end
