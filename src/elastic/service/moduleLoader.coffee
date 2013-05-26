class elastic.service.moduleLoader

  constructor: (@serviceManager) ->

  bootstrapModules: (moduleNamespace) ->
    for ns of moduleNamespace
      for modulename of moduleNamespace[ns]
        @bootstrapModuleIn moduleNamespace[ns], modulename

  bootstrapModuleIn: (module, modulename) ->
    return true if !module[modulename].module?
    new module[modulename].module @serviceManager, @serviceManager.getApp()

    @tryBootstrapServices module[modulename]

    # lets recursive look for modules in the modules folder
    return true if !module[modulename].modules?
    for submodule of module[modulename].modules
      return if !module[modulename].modules[submodule].module?
      @bootstrapModuleIn module[modulename].modules, submodule

  tryBootstrapServices: (moduleDirectory) ->
    return false if !moduleDirectory.services?

    for serviceName of moduleDirectory.services
      serviceKlass = moduleDirectory.services[serviceName]

      if serviceKlass.prototype?.name?
        @serviceManager.setServiceFactory serviceKlass.prototype.name, serviceKlass
