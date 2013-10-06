sio = require('socket.io')
twitter = require('ntwitter')
_ = require("underscore")

module.exports = (compound) ->

  io = compound.io = sio.listen(compound.server)

  twit = new twitter
    consumer_key:        process.env.TWITTER_CONSUMER_KEY
    consumer_secret:     process.env.TWITTER_CONSUMER_SECRET
    access_token_key:    process.env.TWITTER_ACCESS_TOKEN
    access_token_secret: process.env.TWITTER_ACCESS_SECRET

  sending = false

  twit.stream 'statuses/filter', {'locations':'-122.75,36.8,-121.75,37.8'}, (stream) ->
    stream.on 'data', (tweet) ->
      media = tweet.entities.media[0] if tweet.entities.media
      if !sending and media
        setTimeout ->
          io.sockets.emit('photo', media.media_url) if media
          sending = false
        , 1000
      sending = true

  io.sockets.on 'connection', (socket) ->
    console.log "connected"

