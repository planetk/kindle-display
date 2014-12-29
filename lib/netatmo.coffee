netatmo = require('netatmo');
async = require('async');

class NetatmoLib
 constructor: (conf) ->
   @api = new netatmo(conf.auth)
   @devices = conf.devices

 data: (cb) ->
   tasks = {}

   Object.keys(@devices).forEach (device) =>
     tasks[device] = (callback) =>
       @api.getMeasure @devices[device], callback

   async.series tasks, (err, result) ->
     cb null, result 


module.exports = NetatmoLib