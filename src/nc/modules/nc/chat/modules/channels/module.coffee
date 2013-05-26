class nc.modules.nc.chat.modules.channels.module extends elastic.abstractModule

  onReady: ->
    @clientmanager = @sm.getService 'chat.clientmanager'
    @channelmanager = @sm.getService 'chat.channelmanager'
    @clientmanager.on 'client.command.channels', @onClientCommandChannels.bind @

  onClientCommandChannels: (command, client, msg) ->

    buffer = ''

    @channelmanager.eachChannel (channel) ->
      console.log channel.name;
      buffer += '+ ' + channel.name + "\n"
      channel.eachClient (client) ->
        buffer += '|   ' + client.name + "\n"

    client.sendRaw "\n
                   \n
+ Channels & Clients ~\n
" + buffer + "
+ ~ ~ ~ ~\n\n
"
