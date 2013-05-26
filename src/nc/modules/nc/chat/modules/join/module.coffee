class nc.modules.nc.chat.modules.join.module extends elastic.abstractModule

  onReady: ->
    @clientmanager = @sm.getService 'chat.clientmanager'
    @channelmanager = @sm.getService 'chat.channelmanager'
    @clientmanager.on 'client.command.+', @onClientCommandJoin.bind @
    @clientmanager.on 'client.command.-', @onClientCommandUnjoin.bind @

  onClientCommandJoin: (command, client, msg) ->
    return true if typeof msg.args[0] != "string"
    channel = @channelmanager.joinChannel msg.args[0], client
    true

  onClientCommandUnjoin: (command, client, msg) ->
    return true if typeof msg.args[0] != "string"
    channel = @channelmanager.unjoinChannel msg.args[0], client
    true

