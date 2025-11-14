require 'package'
Package.load_package("#{__dir__}/py3_ps_mem.rb")

class Ps_mem < Package
  description Py3_ps_mem.description
  homepage Py3_ps_mem.homepage
  version Py3_ps_mem.version
  license Py3_ps_mem.license
  compatibility Py3_ps_mem.compatibility

  is_fake

  depends_on 'py3_ps_mem'
end
