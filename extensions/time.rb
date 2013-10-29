class Time
  def ymd
    self.strftime("%Y-%m-%d")
  end
  
  def self.me(&block)
  time_a = Time.now
  block.()
  time_b = Time.now
  time_b - time_a
  end
end