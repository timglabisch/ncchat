class elastic.service.serviceManager extends elastic.eventEmitter
  services : {}
  servicesFactories : {}
  moduleLoader: null

  constructor: (@app)->

  setService: (name, service) ->
    @services[name] = service;

  setServiceFactory: (name, serviceFactory) ->
    @servicesFactories[name] = serviceFactory;

  getService: (name) ->
    # first look for services in the serices object
    return @services[name] if @services[name]?

    # may there is a factory for the service
    if @servicesFactories[name]?
      @services[name] = new @servicesFactories[name](@)
      delete @servicesFactories[name]
      return @services[name]

    # now lets try the event manager to fetch the service
    @firstReturn 'service.' + name

  getApp: ->
    @app

  getModuleLoader: ->
    if !@moduleLoader?
      @moduleLoader = new elastic.service.moduleLoader @
    @moduleLoader