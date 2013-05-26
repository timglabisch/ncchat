class nc.modules.nc.tcp.client extends nc.modules.nc.chat.client

  constructor: (@sm, @tcpSocket) ->
    @tcpSocket.on 'data', @_onSocketData.bind @
    @tcpSocket.on 'end', @_onSocketEnd.bind @
    @currentChannel = 'lobby'
    @buf = ''

    # every client joins the lobby be default
    @sm.getService('chat.channelmanager').joinChannel @currentChannel, @

  _onSocketData: (data) ->
    @buf += data.toString();

    if @buf.indexOf("\n") >= 0
      msgs = @buf.split "\n"

      i = 0
      while i < msgs.length - 1
        msg = msgs[i];
        ++i
        @emit 'msg', @, @_parseIncommingMsg msg if msg
      @buf = msgs[msgs.length - 1];

  _onSocketEnd: ->
    @close();

  _parseIncommingMsg: (rawMsg) ->

    # do not deal with empty msg's
    rawMsg = rawMsg.trim();
    return if rawMsg.length < 1

    msg = new nc.modules.nc.chat.msg
    msg.setFrom @

    if rawMsg.substr(0, 1) == '/'
      rawMsg = rawMsg.substr(1)
      rawMsg = rawMsg.split ' '
      msg.command = rawMsg[0];
      msg.setArgs rawMsg.splice 1
      return msg

    msg.setToChannel @currentChannel
    msg.setCommand 'msg'
    msg.setData rawMsg

  send: (msg) ->
    return @close() if !@tcpSocket.writable
    if msg.toChannel
     @tcpSocket.write `"\033[0;32m"` + msg.toChannel + `"\033[0m "`
    @tcpSocket.write `"\033[0;32m"` + msg.from.getName() + `"\033[0m "` + msg.data + "\n"

  close: ->
    @emit 'close', @

