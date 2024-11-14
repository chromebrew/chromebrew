require 'package'
Package.load_package("#{__dir__}/libxss.rb")

class Libxscrnsaver < Package
  description Libxss.description
  homepage Libxss.homepage
  version Libxss.version
  license Libxss.license
  compatibility Libxss.compatibility

  is_fake

  depends_on 'libxss'
end
