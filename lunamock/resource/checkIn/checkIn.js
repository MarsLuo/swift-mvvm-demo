var {response, code} = require('../response.js');
var set = require('./model');
module.exports = [
    {
      path: '/passenger/:pid/checkin',
      method: 'post',
      operation(req, res, next) {
        var {code, body} = checkInSet(req);
        res.send(code, body);
        next();
      }
    }
  ];
  
  function checkInSet(req) {

    let {id, row, section} = req.body;
    row = Number(row)
    section = Number(section)
    if(row == 3 && section == 3) {
      return response(code.success, set.set(id, row, section))
    }else {
      return response(code.paramsError, null, set.error.setHasBeenBook)
    }
  }