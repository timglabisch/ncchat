
var clients, fs, net;

net = require('net');

fs = require('fs');

clients = [];

net.createServer(function(socket) {
  var broadcast, buf, onDataHandle;
  broadcast = function(message, sender) {
    return clients.forEach(function(client) {
      if (client === sender) {
        return;
      }
      if (client.writable) {
        return client.write(message + "\n");
      } else {
        clients.splice(clients.indexOf(client), 1);
        return broadcast(" - - - - - - - - - - - -\n" + client.name + " killed.\n" + " - - - - - - - - - - - -\n");
      }
    });
  };
  onDataHandle = function(msg, socket) {
    var c, tmp, _i, _len;
    if (msg === "/clients") {
      tmp = '+ - - Cients ... ' + "\n";
      for (_i = 0, _len = clients.length; _i < _len; _i++) {
        c = clients[_i];
        tmp += '| ' + c.name + "\n";
      }
      if (socket.writable) {
        socket.write(tmp + "+ - - - - - - - - - - - -\n\n");
      } else {
        clients.splice(clients.indexOf(socket), 1);
        broadcast(" - - - - - - - - - - - -\n" + socket.name + " killed.\n" + " - - - - - - - - - - - -\n");
      }
      return;
    }
    return broadcast(socket.name + ": " + msg, socket);
  };
  socket.name = socket.remoteAddress + ":" + socket.remotePort;
  clients.push(socket);
  socket.write(fs.readFileSync('../welcome') + "\n" + " ~ Welcome " + socket.name + "\n\n" + " - - - - - - - - - - - - - - - - - - - - - - - -\n\n");
  broadcast(" - - - - - - - - - - - -\n" + socket.name + " joined.\n" + " - - - - - - - - - - - -\n", socket);
  buf = '';
  socket.on('data', function(data) {
    var i, msg, msgs;
    buf += data.toString();
    if (buf.indexOf("\n") >= 0) {
      msgs = buf.split("\n");
      i = 0;
      while (i < msgs.length - 1) {
        msg = msgs[i];
        ++i;
        onDataHandle(msg, socket);
      }
      return buf = msgs[msgs.length - 1];
    }
  });
  return socket.on('end', function() {
    clients.splice(clients.indexOf(socket), 1);
    return broadcast(" - - - - - - - - - - - -\n" + socket.name + " left.\n" + " - - - - - - - - - - - -\n");
  });
}).listen(5000);
