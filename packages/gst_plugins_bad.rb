require 'package'

class Gst_plugins_bad < Package
  description 'Multimedia graph framework - bad plugins'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.20.0'
  version @_ver
  license 'LGPL-2'
  compatibility 'all'

  is_fake

  depends_on 'gstreamer'
end
