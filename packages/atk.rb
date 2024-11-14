require 'package'
Package.load_package("#{__dir__}/at_spi2_core.rb")

class Atk < Package
  description At_spi2_core.description
  homepage At_spi2_core.homepage
  version At_spi2_core.version
  license At_spi2_core.license
  compatibility At_spi2_core.compatibility

  is_fake

  depends_on 'at_spi2_core'
end
