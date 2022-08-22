require 'package'

class Orc < Package
  description 'Optimized Inner Loop Runtime Compiler'
  homepage 'https://gitlab.freedesktop.org/gstreamer/orc'
  @_ver = '0.4.32'
  version @_ver
  license 'BSD and BSD-2'
  compatibility 'all'

  is_fake

  depends_on 'gstreamer'
end
