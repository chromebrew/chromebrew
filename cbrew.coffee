program = require 'commander'
fs = require 'fs'
events = require 'events'
global.eventDispatch = new events.EventEmitter

program.version '0.0.1'
program.parse process.argv

action = process.argv[2]
pkgName = process.argv[3]

search = (pkgName, callback) ->
  fs.readdir '.', (err, files) =>
    callback file for file in files when file.indexOf(pkgName) isnt -1

download = (pkgName) ->
  pkg = require './' + pkgName + '.coffee'
  pkg.getBinary()

install = (pkgName) ->
  download pkgName
  eventDispatch.on 'gotFile', ->
    console.log "installing..."

switch action
  when "search" then search pkgName, console.log
  when "download" then download pkgName
  when "install" then install pkgName
