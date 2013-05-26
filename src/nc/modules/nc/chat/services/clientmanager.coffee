class nc.modules.nc.chat.services.clientmanager  extends elastic.abstractService

  name : 'chat.clientmanager'
  clients: [];

  addClient: (client) ->
    @clients.push client
    @emit 'newClient', client
    client.on 'close', @removeClient.bind @
    client.on 'msg', @onMsg.bind @

  removeClient: (client) ->
    @clients.splice(@clients.indexOf(client), 1)

  eachClient: (cb) ->
    @clients.forEach cb

  onMsg: (client, msg) ->
    if !@firstReturn 'client.command.' + msg.command, client, msg
      console.log "unhandeld command " + msg.command



