require 'package'
require_relative 'gstreamer'

class Gst_plugins_bad < Package
  description 'Multimedia graph framework - bad plugins'
  homepage Gstreamer.homepage
  version Gstreamer.version
  license Gstreamer.license
  compatibility Gstreamer.compatibility

  is_fake

  depends_on 'gstreamer'
end
