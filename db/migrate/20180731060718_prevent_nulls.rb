class PreventNulls < ActiveRecord::Migration
  def up
    Episode.where(watched: nil).update_all(watched: false)
    change_column :episodes, :watched, :boolean, null: false, default: false
    Episode.where(title: nil).update_all(title: '')
    change_column :episodes, :title, :string, null: false, default: ''
    Episode.where(episode: nil).update_all(episode: 1)
    change_column :episodes, :episode, :integer, null: false, default: 1
  end

  def down
    change_column :episodes, :watched, :boolean, null: true, default: nil
    change_column :episodes, :title, :string, null: true, default: nil
    change_column :episodes, :episode, :integer, null: true, default: nil
  end
end
