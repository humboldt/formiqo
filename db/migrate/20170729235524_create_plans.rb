class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.decimal :cost
      t.integer :n_mailboxes

      t.timestamps
    end
  end
end
