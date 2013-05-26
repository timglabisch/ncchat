class nc.modules.nc.tcp.module extends elastic.abstractModule

  onReady: ->
    @sm.getService('server.tcp').start();