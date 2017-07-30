class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :plan, foreign_key: true
      t.datetime :end_date

      t.timestamps
    end
  end
end
