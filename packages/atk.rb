require 'package'
require_relative 'at_spi2_core'

class Atk < Package
  description At_spi2_core.description
  homepage At_spi2_core.homepage
  version At_spi2_core.version
  license At_spi2_core.license
  compatibility At_spi2_core.compatibility

  is_fake

  depends_on 'at_spi2_core'
end
