class ReplaceAcFromEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :ac_model, :string
    remove_column :entries, :tail, :string
  end
end
