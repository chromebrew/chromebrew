require 'package'
require_relative 'gstreamer'

class Gst_plugins_base < Package
  description 'An essential, exemplary set of elements for GStreamer'
  homepage 'https://gstreamer.freedesktop.org/modules/gst-plugins-base.html'
  version Gstreamer.version
  license Gstreamer.license
  compatibility Gstreamer.compatibility

  is_fake

  depends_on 'gstreamer'
end
