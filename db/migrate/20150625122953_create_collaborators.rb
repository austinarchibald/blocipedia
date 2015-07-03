class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :user, index: true, foreign_key: true
      t.references :wiki, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_foreign_key :collaborators, :users
    add_foreign_key :collaborators, :wikis
  end
end
