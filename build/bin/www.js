var app, debug, server;

debug = require('../debug')('turquesa');

app = require('../app');

app.set('port', process.env.PORT || 3000);

server = app.listen(app.get('port'), function() {
  return debug('Express server listening on port ' + server.address().port);
});
