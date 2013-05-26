class nc.modules.nc.chat.modules.help.module extends elastic.abstractModule

  onReady: ->
    @clientmanager = @sm.getService 'chat.clientmanager'
    @channelmanager = @sm.getService 'chat.channelmanager'
    @clientmanager.on 'client.command.?', @onClientCommandHelp.bind @

  onClientCommandHelp: (command, client, msg) ->
    client.sendRaw "\n
                   \n
+ HELP ~\n
|\n
| " + `"\033[0;31m/?\033[0m"` + " for help\n
| " + `"\033[0;31m/+ [CHANNEL]\033[0m"` + " joins a channel\n
| " + `"\033[0;31m/- [CHANNEL]\033[0m"` + " unjoins a channel\n
| " + `"\033[0;31m/name [NAME]\033[0m"` + " sets your name\n
| " + `"\033[0;31m/channels\033[0m"` + " displays all channels with all clients\n
|\n
+ ~ ~ ~ ~\n\n
"
