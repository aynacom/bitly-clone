class CreateUrls < ActiveRecord::Migration[5.0]
	def change
		create_table :urls do |t|
			t.string :long_url
			t.string :short_url

			t.timestamps # creates created_at & updated_at
		end
	end
end
