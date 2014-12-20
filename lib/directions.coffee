request = require "superagent"


class Directions
  constructor: (conf) ->
    @googleApiURL = "http://maps.googleapis.com/maps/api/directions/json?origin=#{conf.waypoints[0]}&destination=#{conf.waypoints[1]}&sensor=false"
    @mintime = conf.mintime

  data: (cb) ->
    request.get @googleApiURL, (res) =>
      data = res.body
      traffic = {}
      trafficResource = data.routes[0].legs[0]
      traffic.duration = trafficResource.duration.value
      traffic.extratime = trafficResource.duration.value - @mintime
      cb null, traffic

module.exports = Directions