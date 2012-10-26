class RenameCategorycolumnForIdeas < ActiveRecord::Migration
  def change
  	rename_column :ideas, :category, :category_id
  end
end
