require 'package'
require_relative 'py3_pycairo'

class Pycairo < Package
  description Py3_pycairo.description.to_s
  homepage Py3_pycairo.homepage.to_s
  version Py3_pycairo.version.to_s
  license Py3_pycairo.license.to_s
  compatibility Py3_pycairo.compatibility.to_s

  is_fake

  depends_on 'py3_pycairo'
end
