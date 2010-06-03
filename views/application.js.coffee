$ ->
  c: new io.Socket null, {
    rememberTransport: false,
    resource: 'chat'
  }
  c.connect()
  c.addEvent 'message', (data) ->
    console.log data
    if data.message
      addMessage data
    else if data.buffer
      addMessage m for m in data.buffer

  addMessage: (m) ->
    $('<li>')
      .text(m.message)
      .appendTo $('#chat ul')

  $('form').submit ->
    c.send $(this).serializeArray()[0].value
    $('input:text', this).val ''
    false

  $('form :text:first').select()
