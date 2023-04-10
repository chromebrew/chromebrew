require 'package'
require_relative 'gstreamer'

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage Gstreamer.homepage.to_s
  version Gstreamer.version.to_s
  license Gstreamer.license.to_s
  compatibility Gstreamer.compatibility.to_s

  is_fake

  depends_on 'gstreamer'
end
