class nc.modules.nc.chat.services.channelmanager  extends elastic.abstractService

  name : 'chat.channelmanager'

  constructor: (@sm) ->
    @channels = []


  unjoinChannel: (name, client) ->
    if typeof @channels[name] == "undefined"
      return false

    return @channels[name].unJoin client

  joinChannel: (name, client) ->
    console.log "client " + client.getName() + " wants to join channel " + name

    if typeof @channels[name] != "undefined"
      return @channels[name]

    console.log "create channel " + name

    channel = new nc.modules.nc.chat.channel name
    channel.join client

    client.on 'close', =>
      return if typeof @channels[name] == "undefined"
      @channels[name].unJoin client

    channel.on 'unjoin', (client, channel) =>
      console.log "client " + client.getName() + " unjoins " + channel.name
      return if channel.getClients().length != 0
      @channels.splice(@channels.indexOf(channel), 1)
      console.log "channel " + channel.name + " dropped"

    @channels[name] = channel

    return @channels[name];






