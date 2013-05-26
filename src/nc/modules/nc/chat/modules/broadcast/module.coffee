class nc.modules.nc.chat.modules.broadcast.module extends elastic.abstractModule

  onReady: ->
    @clientmanager = @sm.getService 'chat.clientmanager'
    @clientmanager.on 'client.command.msg', @onClientCommandMsg.bind @

  onClientCommandMsg: (command, c, msg) ->
    @clientmanager.eachClient (client) ->
      # dont broadcast to the sender ...
      return if client == c
      client.send msg
    true
