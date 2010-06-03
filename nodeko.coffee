get /.*/, ->
  [host, path]: [@headers.host, @url.href]
  if host == 'www.nodeknockout.com' or host == 'nodeknockout.heroku.com'
    @redirect 'http://nodeknockout.com' + path, 301
  else
    @pass()

get '/', ->
  @render 'index.html.haml'

get '/*.js', (file) ->
  try
    @render "${file}.js.coffee", { layout: false }
  catch e
    @pass "/${file}.js"

get '/*.css', (file) ->
  @render "${file}.css.sass", { layout: false }

get '/*', (file) ->
  @pass "/public/${file}"

server: run parseInt(process.env.PORT || 8000), null

# handle web sockets
sio: require './lib/socket.io/lib/socket.io'
buffer: []
chat: sio.listen server, {
  resource: 'chat'
  transports: 'websocket htmlfile xhr-multipart xhr-polling'.split(' ')
  onClientConnect: (client) ->
    client.send { buffer: buffer }
    chat.broadcast { status: "${client.sessionId} connected" }
  onClientDisconnect: (client) ->
    chat.broadcast { status: "${client.sessionId} disconnected" }
  onClientMessage: (message, client) ->
    chat.broadcast m: { message: message, client: client.sessionId }
    buffer.push m
}
