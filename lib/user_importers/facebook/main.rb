require 'koala'

class Importer::Facebook
  attr_accessor :rest, :graph

  def initialize(credentials)
    @rest = Koala::Facebook::API.new(credentials)
    @graph = Koala::Facebook::API.new(credentials)
  end
  
  def collect
    profile = @graph.get_object("me")
    friends = @graph.get_connections("me", "friends")
    
    return {:ego => profile, :friends => friends}
  end
end
f = Importer::Facebook.new("CAAH7lYkFi0UBAJAcZC1jzZBZB5Lfb8poyWUymc4qTi1aFi8MZBgcZCDPqjUwSrAhoOQZABQjlP1Fg9OYRPeqjcfKh1CQ2z3UMnfZA83xddUxqtofY4AMwvvokp61gIhKoZCgKyRj0OdZCoSkDJpj75ANdzZCuGWnkHf5gZD")
f.collect
f.graph.get_connections("69000529", "CONNECTION/1082")