class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :uname
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
