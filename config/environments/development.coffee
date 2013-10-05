express = require 'express'

module.exports = (compound) ->
  app = compound.app
  app.configure 'development', ->
    app.enable 'watch'
    app.enable 'log actions'
    app.enable 'env info'
    app.enable 'force assets compilation'
    app.set 'translationMissing', 'display'
    app.set 'view engine', 'jade'
    app.enable('merge javascripts');
    app.enable('merge stylesheets');
    app.use express.errorHandler dumpExceptions: true, showStack: true
