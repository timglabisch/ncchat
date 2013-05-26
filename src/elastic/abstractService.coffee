#<< elastic/eventEmitter

class elastic.abstractService extends elastic.eventEmitter

  # name of the Service
  @name = null

  # Instance of the Service Manager normal times elastic.service.serviceManager
  @sm = null

  constructor: (@sm) ->

  setName: (@name) ->

  getName: () ->
    throw new elastic.exception if !@name?
    @name