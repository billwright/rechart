class UsageChartController < ApplicationController

  def chart
  end


  def fetchData

    from_date = DateTime.now

    if params[:from_date].present?
      from_date = DateTime.strptime(params[:from_date], '%Y-%m-%d').in_time_zone("Mountain Time (US & Canada)")
    end

    chart_data = Array.new

    #usage data series
    usage_data = UsageService.new().dailyUsage from_date
    addSeries(chart_data, "Usage", usage_data)

    # weather data series
    weather_data = WeatherService.new().dailyHistory from_date
    addSeries(chart_data, "Weather", weather_data)

    respond_to do |format|
      format.json { render :json => chart_data }
    end

  end

 def addSeries( chart_data, series_name, data)
   data_series = Hash.new
   data_series["series"] = series_name
   data_series["data"] = data
   chart_data.push(data_series)
 end

end
