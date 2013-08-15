#!/usr/local/bin/coffee

program = require 'commander'
fs = require 'fs'
events = require 'events'
global.eventDispatch = new events.EventEmitter
crypto = require 'crypto'

program.version '0.0.1'
program.parse process.argv

action = process.argv[2]
pkgName = process.argv[3]

@pkg = (pkgName) ->
  eventDispatch.on 'packageFound', ->
    @pkg = require './formulas/' + pkgName + '.coffee'
  eventDispatch.on 'packageNotFound', ->
    console.log 'package ' + pkgName + ' not found :('
    process.exit 1
  
  look_for pkgName

look_for = (pkgName) ->
  fs.readdir 'formulas', (err, files) ->
    return eventDispatch.emit 'packageFound' for file in files when file.indexOf(pkgName) isnt -1
    return eventDispatch.emit 'packageNotFound'

search = (pkgName) =>
  @pkg pkgName
  eventDispatch.on 'packageFound', ->
    console.log pkgName + ' found!'

download = (pkgName) =>
  @pkg pkgName
  eventDispatch.on 'packageFound', ->
    @pkg.getSource() unless @pkg.getBinary()
  eventDispatch.on 'filename', (filename) ->
    @pkg.filename = filename
  eventDispatch.on 'gotPackage', ->
    sha1sum = crypto.createHash 'sha1'
    stream = fs.ReadStream @pkg.filename
    stream.on 'data', (data) ->
      sha1sum.update data
    stream.on 'end', ->
      digest = sha1sum.digest 'hex'
      console.log digest

install = (pkgName) =>
  download pkgName

  eventDispatch.on 'gotPackage', ->
    @pkg.build() unless @pkg.installBinary()

switch action
  when "search" then search pkgName
  when "download" then download pkgName
  when "install" then install pkgName
