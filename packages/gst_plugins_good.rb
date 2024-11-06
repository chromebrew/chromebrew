require 'package'
Package.load_package("#{__dir__}/gstreamer.rb")

class Gst_plugins_good < Package
  description 'Multimedia graph framework - good plugins'
  homepage Gstreamer.homepage
  version Gstreamer.version
  license Gstreamer.license
  compatibility Gstreamer.compatibility

  is_fake

  depends_on 'gstreamer'
end
