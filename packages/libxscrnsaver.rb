require 'package'
require_relative 'libxss'

class Libxscrnsaver < Package
  description Libxss.description.to_s
  homepage Libxss.homepage.to_s
  version Libxss.version.to_s
  license Libxss.license.to_s
  compatibility Libxss.compatibility.to_s

  is_fake

  depends_on 'libxss'
end
