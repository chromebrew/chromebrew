require 'package'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  @_ver = '1.20.0'
  version @_ver
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'

  is_fake

  depends_on 'gstreamer'
end
