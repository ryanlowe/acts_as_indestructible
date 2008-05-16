class CreateIndestructibleUsers < ActiveRecord::Migration
  def self.up
    create_table :indestructible_users do |t|
      t.datetime :created_at
      t.datetime :created_by
      t.datetime :updated_at
      t.datetime :updated_by
      t.datetime :deleted_at
      t.datetime :deleted_by
      t.string   :username
      t.boolean  :is_admin, :default => false
    end
  end

  def self.down
    drop_table :indestructible_users
  end
end
