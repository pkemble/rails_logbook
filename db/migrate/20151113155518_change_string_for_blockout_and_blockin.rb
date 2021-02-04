class ChangeStringForBlockoutAndBlockin < ActiveRecord::Migration[4.2]
  def change
    change_column :flights, :blockout, :string
    change_column :flights, :blockin, :string
  end
end
