class CreateViewers < ActiveRecord::Migration[6.0]
  def change
    create_table :viewers do |t|
      t.string :name
      t.string :surname
      t.string :credit_card_number
      t.string :cvv

      t.timestamps
    end
  end
end
