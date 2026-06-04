require 'package'
Package.load_package("#{__dir__}/py3cairo.rb")

class Pycairo < Package
  description Py3cairo.description
  homepage Py3cairo.homepage
  version Py3cairo.version
  license Py3cairo.license
  compatibility Py3cairo.compatibility

  is_fake

  depends_on 'py3cairo'
end
