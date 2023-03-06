require 'package'

class At_spi2_atk < Package
  description 'D-Bus AT-SPI'
  homepage 'http://www.freedesktop.org/'
  version At_spi2_core.version
  license 'LGPL-2.1+'
  compatibility 'all'

  depends_on 'at_spi2_core'

  is_fake
end
