class nc.modules.nc.chat.modules.broadcast.module extends elastic.abstractModule

  onReady: ->
    @clientmanager = @sm.getService 'chat.clientmanager'
    @clientmanager.on 'client.command.msg', @onClientCommandMsg.bind @
    @channelmanager = @sm.getService 'chat.channelmanager'

  onClientCommandMsg: (command, c, msg) ->
    if msg.toChannel == null
      return true

    @channelmanager.broadcastToChannel msg.toChannel, msg
    true
