require 'package'
require_relative 'gstreamer'

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage Gstreamer.homepage
  version Gstreamer.version
  license Gstreamer.license
  compatibility Gstreamer.compatibility

  is_fake

  depends_on 'gstreamer'
end
