class CreateInvite < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :github_handle
    end
  end
end
