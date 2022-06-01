require 'package'

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.20.0'
  version @_ver
  license 'LGPL-2'
  compatibility 'all'

  is_fake
end
