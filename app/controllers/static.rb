require 'securerandom'

get '/' do
	@urls=Url.all.order("created_at DESC")
  erb :"static/index"
end

post '/shorten' do
# p params["long_url"]
@url = Url.new(long_url: params["long_url"], short_url: SecureRandom.hex(4)) # to create a row
	if @url.save

	# redirect '/'

	else
@errors = @url.errors.full_messages.join(",") #this is error message given from ActiveRecord  
	end
# p params
# "example"
	 # need code to remember error var when it is not saved successfully, thats why loading erb instead of redirecting to '/' because once redirecting the code will forget the defined local var
	 @urls=Url.all.order("created_at DESC")
	 # redirect "/?abc=#{@errors}" to redirect and remember variable, abc will be sent to the redirected page, params["abc"]
	erb :"static/index"
end

post '/:url_id/vote' do
	# whatever you c on the browser is the value, and then key i set to id by inserting: here
	# 1) find  out which url i am upvoting
	@url = Url.find(params[:url_id])
	@url.click_count+=1
	@url.save
	redirect '/'

end

get '/:shortshort' do

	# 1)look for this url now
	@url = Url.find_by(short_url: params[:shortshort])
	# 2) increase the click count
	@url.click_count +=1
	@url.save
	# 3) redirect to long url
	redirect to "#{@url.long_url}"

end