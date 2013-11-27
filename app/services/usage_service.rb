class UsageService

  def dailyUsage date
    usage_data = Array.new
    auth = {:username => "tkarpeichik@tendrilinc.com", :password => "password1"}

    response = HTTParty.get(createUrl(date), :basic_auth => auth)
    response['costAndConsumption']['component'].each do |c|
      to_date = DateTime.parse(c['toDate'])
      from_date = DateTime.parse(c['fromDate'])
      diff_hours = ((to_date - from_date) * 24).to_f
      mid_date = from_date + (diff_hours / 2).hours
      avg_usage = (c['consumption'].to_f * 1000.00) / diff_hours
      usage_data.push([unixTimestamp(mid_date), avg_usage])
    end
    usage_data
  end

  def unixTimestamp (datetime)
    datetime.strftime('%s').to_i * 1000
  end

  def createUrl date
    format = '%Y-%m-%dT%H:%M:%S%:z'
    resolution = 'QUARTER_HOURLY'
    from = (date.beginning_of_day).strftime(format)
    to =  (date.end_of_day).strftime(format)
    url = 'https://family.tendrildemo.com/api/rest/user/current-user/account/default-account/consumption/' + resolution + ';from=' + from + ';to=' + to + ';include-submetering-devices=true'
    puts url
    url
  end

end