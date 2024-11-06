require 'package'
Package.load_package("#{__dir__}/py3_pycairo.rb")

class Pycairo < Package
  description Py3_pycairo.description
  homepage Py3_pycairo.homepage
  version Py3_pycairo.version
  license Py3_pycairo.license
  compatibility Py3_pycairo.compatibility

  is_fake

  depends_on 'py3_pycairo'
end
