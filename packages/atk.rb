require 'package'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other toolkits and applications'
  homepage 'https://developer.gnome.org/atk'
  version At_spi2_core.version
  compatibility 'all'
  license 'LGPL-2+'

  depends_on 'at_spi2_core'

  is_fake
end
