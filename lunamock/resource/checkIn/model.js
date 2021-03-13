const Random = require('mockjs').Random;
const faker = require('faker');

var {error} = require('../response.js');

var set = (id,row, section) => {
    return {
        id,
        row,
        section,
        status: 2, 
    };
}

var error = {
    setHasBeenBook: error("100001", "该座位已经被预订")
}

var setModle = {
    set,
    error
}

module.exports = setModle;