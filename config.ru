use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['rlh', 'rlh']
end

require 'rack/jekyll'
run Rack::Jekyll.new
