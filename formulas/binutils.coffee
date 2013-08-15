network = require '../network.coffee'

module.exports =
  binary_url: "https://dl.dropboxusercontent.com/s/u3cp7mpdyfx99ij/binutils-2.23.2-chromeos-i686.tar.gz?token_hash=AAGsFB9HXNb5tSAm_Wd2GyIUL59BkZYgMTHkj4CkHLxggg&dl=1"
  binary_sha1: ""
  
  binary_install: ->
    
  getBinary: ->
    network.getFile @binary_url

  build: ->
    system './configure'
    system 'make'
  
  install: ->
    system 'make install'
