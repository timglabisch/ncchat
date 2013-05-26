class nc.modules.nc.chat.client extends elastic.eventEmitter

  # triggers 'msg' if there is a new msg

  name : null

  constructor: ->
    throw new {'msg': 'abstract method'}

  close: ->
    throw new {'msg': 'abstract method'}

  getName: ->
    @name = "guest" + ((Math.random() * 100000).toString().substr(0, 5)) if !@name?
    @name

  setName: (@name) ->

  channelJoined: (channel) ->
    @currentChannel = channel.name
