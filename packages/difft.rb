require 'package'
require_relative 'difftastic'

class Difft < Package
  description Difftastic.description
  homepage Difftastic.homepage
  version Difftastic.version
  license Difftastic.license
  compatibility Difftastic.compatibility

  is_fake

  depends_on 'difftastic'
end
