before do
  content_type :json if request.path.include?(".json")
end

before "/news*" do
  conditions = pagination_conditions(params)
  @locals = news_locals(conditions)  
end