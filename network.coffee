https = require 'https'
progressbar = require 'progress'
fs = require 'fs'

module.exports.getFile = (url) ->
  https.get url, (res) ->
    len = parseInt res.headers['content-length'], 10
    content_disposition = res.headers['content-disposition']
    filename = content_disposition.substring content_disposition.indexOf('"')+1, content_disposition.length-1
    eventDispatch.emit 'filename', filename

    console.log();
    bar = new progressbar ' downloading [:bar] :percent :etas', {
      complete: '='
      incomplete: ' '
      width: 20
      total: len
    }

    res.on 'data', (chunk) ->
      fs.appendFileSync filename, chunk
      bar.tick chunk.length

    res.on 'end', ->
      eventDispatch.emit 'gotPackage'
