class Fixnum
  def is_nan?
    impossible_set = [self > 0, self < 0, self == 0]
    return impossible_set.uniq.length == 1 && impossible_set.first == false
  end
end