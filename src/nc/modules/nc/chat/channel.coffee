class nc.modules.nc.chat.channel extends elastic.eventEmitter

  constructor: (@name) ->
    @clients = []

  getClients: ->
    @clients

  eachClient: (cb) ->
    @clients.forEach cb

  join: (client) ->
    @clients.push client
    @emit 'join', client

  unJoin: (client) ->
    index = @clients.indexOf(client)
    return false if index == -1
    @clients.splice(index, 1)
    @emit 'unjoin', client, @

  broadcast: (msg) ->
    @clients.forEach (client) ->
      # dont broadcast to the sender ...
      return if client == msg.from
      client.send msg

