# src folder
toast 'src'

  # excluded items (will be used as a regex)
  exclude: [
    '.*vendors.*'
  ]

  # packaging vendors among the code
  vendors: [
    'src/elastic/vendors/eventEmitter2/eventEmitter2.js'
  ]

  # gereral options (all is optional, default values listed)
  bare: true
  packaging: true
  expose: 'exports' # can be 'window', 'exports' etc
  minify: false

  # httpfolder (optional), release and debug (both required)
  httpfolder: 'out'
  release: 'out/nc.js'
  debug: 'out/nc_debug.js'