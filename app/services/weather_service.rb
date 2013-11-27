class WeatherService

  def dailyHistory date
    weather_data = Array.new

    #response = HTTParty.get('http://api.wunderground.com/api/3711ac5a82e71413/history_20131122/q/CO/Boulder.json')
    response = HTTParty.get(createUrl(date))
    response["history"]["observations"].each do |obs|
      observation = Hash.new
      od = obs["date"]
      observation["date"] = DateTime.new(od["year"].to_i, od["mon"].to_i, od["mday"].to_i, od["hour"].to_i, od["min"].to_i, 0, '-7')
      observation["tempi"] = obs["tempi"]
      observation["tempm"] = obs["tempm"]
      weather_data.push([unixTimestamp(observation["date"]), observation["tempi"].to_f])
    end
    weather_data
  end

  def unixTimestamp (datetime)
    datetime.strftime('%s').to_i * 1000
  end

  def createUrl date
    format = '%Y%m%d'
    from = (date).strftime(format)
    url = 'http://api.wunderground.com/api/3711ac5a82e71413/history_' + from + '/q/CO/Boulder.json'
    puts url
    url
  end

end