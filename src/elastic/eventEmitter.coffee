class elastic.eventEmitter extends exports.EventEmitter2
  firstReturn: (eventName) ->
    listeners = @listeners eventName
    return false if !listeners

    for listener in listeners
      value = listener.apply(@, Array.prototype.slice.call(arguments))
      return value if value

    return false

