class CreateComments < ActiveRecord::Migration[5.1]
  def change
    # create_table :comments do |t|
    create_table :comments do |t|
      t.text :content
      # t.references :user,   foreign_key: true
      # t.references :movie, foreign_key: true
      t.references :user,   null: false, foreign_key: true
      t.references :movie,  null: false

      t.timestamps
    end
    add_index :comments, [:user_id, :movie_id, :created_at]
    add_foreign_key :comments, :movies, column: :movie_id, primary_key: :id
  end
end
