var restify = require('restify');

const server = restify.createServer({
  name: 'LunaMock',
  version: '1.0.0'
});

server.use(restify.plugins.acceptParser(server.acceptable));
server.use(restify.plugins.queryParser());
server.use(restify.plugins.bodyParser());

server.use(restify.plugins.authorizationParser());
server.use(restify.plugins.dateParser());
server.use(restify.plugins.gzipResponse());
server.pre(restify.pre.sanitizePath());

server.pre(function(req, res, next) {
  res.charSet('utf-8');
  res.cache({maxAge: 0});
  next();
});
 
// 路由配置
require('./routes')(server, {baseURL: '/api/v1/mobile'});

const port = 8080;
const host = '192.168.50.97';
server.listen(port, host, () => {
  console.log('Mock server listening at %s', server.url);
});

server.on('restifyError', function(req, res, err, callback) {
  err.toJSON = function customToJSON() {
      return { error:{
          name: err.name,
          message: err.message
        }
      };
  };
  return callback();
});