class AddScoreAndStatusToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :score, :integer
    add_column :ideas, :status, :integer
  end
end
