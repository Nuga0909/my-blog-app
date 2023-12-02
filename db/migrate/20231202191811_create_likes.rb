class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: { to_table: :posts }
      t.timestamps
    end
  end
end
