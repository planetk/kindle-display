request = require "superagent"

icons = 
  "None": "road39"
  "Mild": "clock117"

class Traffic
  constructor: (conf) ->
    @bingApiURL = "http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=#{conf.waypoints[0]}&wp.1=#{conf.waypoints[1]}&key=#{conf.bing_key}"

  data: (cb) ->
    request.get @bingApiURL, (res) =>
      data = res.body
      console.log data
      traffic = {}
      sets = data.resourceSets[0]
      if sets? 
        trafficResource = sets.resources[0]
        traffic.congestion = trafficResource.trafficCongestion  # None, Mild, ...
        traffic.duration = trafficResource.travelDurationTraffic
        if icons[traffic.congestion]?
          traffic.icon = "/images/traffic/#{icons[traffic.congestion]}.svg"
        traffic.extratime = trafficResource.travelDurationTraffic - trafficResource.travelDuration

      cb null, traffic

module.exports = Traffic