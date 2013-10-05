error do
  @error = request.env['sinatra_error']
  erb :"errors/500", :locals => @locals
end

not_found do
  erb :"errors/404", :locals => @locals
end