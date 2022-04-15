class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    # create_table :movies do |t|
    create_table :movies, id: false do |t|  
      t.string :title
      t.string :poster_path
      t.bigint :id, null: false, primary_key: true

      # t.timestamps
    end
  end
end