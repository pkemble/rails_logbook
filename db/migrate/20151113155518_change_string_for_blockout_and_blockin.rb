class ChangeStringForBlockoutAndBlockin < ActiveRecord::Migration
  def change
    change_column :flights, :blockout, :string
    change_column :flights, :blockin, :string
  end
end
