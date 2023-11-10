require 'package'
require_relative 'libxss'

class Libxscrnsaver < Package
  description Libxss.description
  homepage Libxss.homepage
  version Libxss.version
  license Libxss.license
  compatibility Libxss.compatibility

  is_fake

  depends_on 'libxss'
end
