class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners do |t|
      t.string :materials, array: true, default: []
      t.st_point :address, geographic: true, null: false
      t.float :rating, null: true
      t.integer :operating_radius, null: false
      t.timestamps
    end

    add_index :partners, :address, using: :gist
  end
end
