require 'package'
require_relative 'at_spi2_core'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other toolkits and applications'
  homepage 'https://developer.gnome.org/atk'
  @atkversion = At_spi2_core.version
  version @atkversion
  compatibility 'all'
  license 'LGPL-2+'

  depends_on 'at_spi2_core'

  is_fake
end
