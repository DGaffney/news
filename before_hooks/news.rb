before do
  content_type :json if request.path.include?(".json")
end

before "/news*" do
  # conditions = pagination_conditions(params)
  # @locals = news_locals(conditions)
  binding.pry
  Score.a_priori_limit_offset(time_range(params)).collect(&:article_id)
end