sio = require('socket.io')
twitter = require('ntwitter')

module.exports = (compound) ->

  io = compound.io = sio.listen(compound.server)

  twit = new twitter
    consumer_key:        process.env.TWITTER_CONSUMER_KEY
    consumer_secret:     process.env.TWITTER_CONSUMER_SECRET
    access_token_key:    process.env.TWITTER_ACCESS_TOKEN
    access_token_secret: process.env.TWITTER_ACCESS_SECRET

  io.sockets.on 'connection', (socket) ->
    twit.stream 'statuses/filter', {'track': '#SNL'}, (stream) ->
      stream.on 'data', (data) ->
        socket.emit('photo', data)
