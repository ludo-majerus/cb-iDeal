class AddTitleBodyToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :title, :string
    add_column :ideas, :body, :text
    add_column :ideas, :published, :boolean

    remove_column :ideas, :nom

  end
end
