before do
  content_type :json if request.path.include?(".json")
end

before "/news*" do
  @locals = news_locals(params.merge(pagination_conditions(params)))
end