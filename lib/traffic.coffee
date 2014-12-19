request = require "superagent"


class Traffic
  constructor: (conf) ->
    @bingApiURL = "http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=#{conf.waypoints[0]}&wp.1=#{conf.waypoints[1]}&key=#{conf.bing_key}"

  data: (cb) ->
    request.get @bingApiURL, (res) =>
      data = res.body
      trafficResource = data.resourceSets[0].resources[0]
      traffic.congestion = trafficResource.trafficCongestion
      traffic.duration = trafficResource.travelDurationTraffic
      traffic.extratime = trafficResource.travelDurationTraffic - trafficResource.travelDuration

      cb null, traffic

module.exports = Traffic