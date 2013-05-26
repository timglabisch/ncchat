class nc.modules.nc.chat.services.channelmanager  extends elastic.abstractService

  name : 'chat.channelmanager'

  constructor: (@sm) ->
    @channels = {}

  eachChannel: (cb)->
    for c of @channels
      cb @channels[c];

  unjoinChannel: (name, client) ->
    if typeof @channels[name] == "undefined"
      return false

    return @channels[name].unJoin client

  broadcastToChannel: (name, msg) ->
    if typeof @channels[name] == "undefined"
      return false

    return @channels[name].broadcast msg

  joinChannel: (name, client) ->

    if typeof @channels[name] == "undefined"
      console.log "create channel " + name
      channel = new nc.modules.nc.chat.channel name

      # drop channel if empty
      channel.on 'unjoin', (client, channel) =>
        console.log "client " + client.getName() + " unjoins " + channel.name
        return if channel.getClients().length != 0
        @channels.splice(@channels.indexOf(channel), 1)
        console.log "channel " + channel.name + " dropped"

      @channels[name] = channel

    client.channelJoined @channels[name]
    @channels[name].join client

    console.log "client " + client.getName() + " joins channel " + name

    client.on 'close', (client) =>
      console.log("drop client by channelmannager!")
      if typeof @channels[name] == "undefined"
        return console.log("debug: cant drop empty channel")
      @channels[name].unJoin client

    return @channels[name];






