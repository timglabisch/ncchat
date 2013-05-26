net = require 'net';

class nc.modules.nc.tcp.services.server  extends elastic.abstractService

  name : 'server.tcp'

  server: null
  port: 4242

  constructor: (@sm) ->
    @clientmanager = @sm.getService('chat.clientmanager');

  start: ->
    console.log "start tcp server"
    throw new {msg : "server is already running"} if @server != null
    net.createServer(
      @onNewClientConnection.bind @
    ).listen @port

  onNewClientConnection: (socket) ->
    client = new nc.modules.nc.tcp.client @sm, socket;
    @clientmanager.addClient client
