class AddConstraintsToApis < ActiveRecord::Migration[8.1]
  def change
    change_column_null :apis, :name, false
    change_column_null :apis, :url, false
  end
end
