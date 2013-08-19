#!/usr/local/bin/coffee

program = require 'commander'
fs = require 'fs'
events = require 'events'
global.eventDispatch = new events.EventEmitter
crypto = require 'crypto'
tgz = require 'tar.gz'
ncp = require 'ncp'
ncp = ncp.ncp
network = require './network.coffee'

ncp.limit = 16
program.version '0.0.1'
program.parse process.argv

@device = require './device.json'
action = process.argv[2]
pkgName = process.argv[3]

@pkg = (pkgName) ->
  eventDispatch.on 'packageFound', ->
    @pkg = require './formulas/' + pkgName + '.coffee'
    global.pkgVersion = @pkg.version
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
    if @pkg.binary_url then network.getFile @pkg.binary_url else network.getFile @pkg.source_url

  eventDispatch.on 'filename', (filename) ->
    @pkg.filename = filename
  eventDispatch.on 'gotPackage', ->
    sha1sum = crypto.createHash 'sha1'
    stream = fs.ReadStream @pkg.filename
    stream.on 'data', (data) ->
      sha1sum.update data
    stream.on 'end', =>
      digest = sha1sum.digest 'hex'
      checksum = @pkg.binary_sha1 or @pkg.source_sha1
      eventDispatch.emit 'packageSumOk' unless digest isnt checksum

install = (pkgName) =>
  eventDispatch.on 'extractedPackage', =>
    console.log 'installing package...'
    fs.rename './usr', './xd', =>
      @device.installed_packages.push { name: pkgName, version: pkgVersion }
      fs.writeFile './device.json', JSON.stringify @device, null, 2
      fs.rename './dlist', './meta/' + pkgName + '.directorylist'
      fs.rename './filelist', './meta/' + pkgName + '.filelist', ->
        console.log 'package ' + pkgName + ' installed!'

  eventDispatch.on 'packageSumOk', ->
    console.log 'extracting archive...'
    new tgz().extract './' + @pkg.filename, '.', (error) =>
      eventDispatch.emit 'extractedPackage' unless error
      fs.unlink './' + @pkg.filename, (error) ->
        throw error if error

  download pkgName

remove = (pkgName) =>
  fs.readFile './meta/' + pkgName + '.filelist', (error, data) =>
    throw error if error
    filelist_lines = data.toString().split '\n'
    for line in filelist_lines
      unless not line
        fs.unlink '.' + line, (error) ->
          throw error if error
    fs.readFile './meta/' + pkgName + '.directorylist', (error, data) ->
      throw error if error
      directorylist_lines = data.toString().split '\n'
      for line in directorylist_lines.reverse()
        unless not line
          fs.rmdirSync '.' + line
    @device.installed_packages = @device.installed_packages.filter (pkg) -> pkg.name isnt pkgName
    fs.writeFileSync './device.json', JSON.stringify @device, null, 2
    fs.unlink './meta/' + pkgName + '.filelist'
    fs.unlink './meta/' + pkgName + '.directorylist'
    console.log pkgName + ' removed!'

showStatus = =>
  console.log pkg.name + ': ' + pkg.version for pkg in @device.installed_packages

switch action
  when "search" then search pkgName
  when "download" then download pkgName
  when "install" then install pkgName
  when "remove" then remove pkgName
  when "status" then showStatus()
