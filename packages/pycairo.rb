require 'package'
require_relative 'py3_pycairo'

class Pycairo < Package
  description Py3_pycairo.description
  homepage Py3_pycairo.homepage
  version Py3_pycairo.version
  license Py3_pycairo.license
  compatibility Py3_pycairo.compatibility

  is_fake

  depends_on 'py3_pycairo'
end
