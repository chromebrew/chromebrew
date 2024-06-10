require 'package'
require_relative 'py3_mercurial'

class Hg < Package
  description Py3_mercurial.description
  homepage Py3_mercurial.homepage
  version Py3_mercurial.version
  license Py3_mercurial.license
  compatibility Py3_mercurial.compatibility

  is_fake

  depends_on 'py3_mercurial'
end
