class AddUserToAircraft < ActiveRecord::Migration[5.0]
  def change
    add_reference :aircraft, :user, foreign_key: true
  end
end
