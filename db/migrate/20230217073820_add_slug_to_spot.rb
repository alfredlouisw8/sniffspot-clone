class AddSlugToSpot < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :slug, :string
  end
end
