class nc.modules.nc.chat.modules.name.module extends elastic.abstractModule

  onReady: ->
    @clientmanager = @sm.getService 'chat.clientmanager'
    @clientmanager.on 'client.command.name', @onClientCommandMsg.bind @

  onClientCommandMsg: (command, client, msg) ->
    return true if typeof msg.args[0] != "string"
    client.setName msg.args[0]
    true
