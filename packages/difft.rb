require 'package'
Package.load_package("#{__dir__}/difftastic.rb")

class Difft < Package
  description Difftastic.description
  homepage Difftastic.homepage
  version Difftastic.version
  license Difftastic.license
  compatibility Difftastic.compatibility

  is_fake

  depends_on 'difftastic'
end
