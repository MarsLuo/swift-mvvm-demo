var {response, code} = require('../response.js');
var set = require('./model');
module.exports = [
    {
      path: '/passenger/:pid/checkin',
      method: 'get',
      operation(req, res, next) {
        var {code, body} = checkInSet(req);
        res.send(code, body);
        next();
      }
    }
  ];
  
  function checkInSet(req) {
    var jsonBody = JSON.parse(req.body);
    let {id, row, section} = jsonBody;
    if(row===3&&section==3) {
      return response(code.success, set.set(id, row, section))
    }else {
      return response(code.paramsError, null, set.error.setHasBeenBook)
    }
  }