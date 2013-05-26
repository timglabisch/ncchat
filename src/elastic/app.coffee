class elastic.app extends elastic.eventEmitter

  constructor: (@serviceManager = new elastic.service.serviceManager @) ->

  bootstrap: (moduleDirectories = []) ->

    for module in moduleDirectories
      @serviceManager.getModuleLoader().bootstrapModules module

    @emit 'app.ready'

  isDebugMode: ->
    true

  getServiceManager: ->
    @serviceManager
