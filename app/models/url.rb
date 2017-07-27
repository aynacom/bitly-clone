class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :long_url, uniqueness: true
	validates :long_url, format: {with: (URI::regexp(['http', 'https'])), message: "entered is invalid url"}
end
