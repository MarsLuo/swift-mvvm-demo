var {response, code} = require('../response.js');
var set = require('./model');
module.exports = [
    {
      path: '/passenger/:pid/checkin',
      method: 'post',
      operation(req, res, next) {
        console.log("----------")
        console.log(req.body)
        var {code, body} = checkInSet(req);
        console.log("code" + code)
        console.log("body" + JSON.stringify(body))
        res.send(code, body);
        next();
      }
    }
  ];
  
  function checkInSet(req) {

    console.log("checkInSet body" + req.body)
    // var jsonBody = JSON.parse(req.body);
    let {id, row, section} = req.body;
    row = Number(row)
    section = Number(section)
    console.log("checkInSet id" + id +" row" + row + "section " + section)
    if(row == 3 && section == 3) {
      return response(code.success, set.set(id, row, section))
    }else {
      return response(code.paramsError, null, set.error.setHasBeenBook)
    }
  }