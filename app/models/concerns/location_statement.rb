class LocationStatement
  attr_reader :statement

  def initialize(statement)
    @statement = statement.downcase
  end

  def location
    @location ||= Location.parse(@statement)
  end

  def message
    @message ||= @statement.split(",").length > 1 && @statement.split(",").last.strip.capitalize
  end

  def time
    @time ||= Chronic.parse(post_location_text) # || Chronic.parse('today')
  end

  def post_location_text
    @statement.split(matched_location_keyword).last.strip
  end

  def matched_location_keyword
    location.class.keywords.select do |keyword|
      @statement.include? keyword
    end.last
  end

  def valid?
    !location.nil? && !time.nil?
  end

  def to_s
    "#{@statement} \n#{ valid? ? "#{location} on #{print_date(time)}" : "Invalid" }"
  end

  def print_date(time)
    time.strftime("%a %d %H%p")
  end

end
