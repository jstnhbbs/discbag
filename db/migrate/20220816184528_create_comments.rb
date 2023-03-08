class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :commented_disc, foreign_key: { to_table: "discs" }
      t.references :commenter, foreign_key: { to_table: "users"}

      t.timestamps
    end
  end
end
