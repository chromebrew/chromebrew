require 'package'
Package.load_package("#{__dir__}/gstreamer.rb")

class Gst_plugins_bad < Package
  description 'Multimedia graph framework - bad plugins'
  homepage Gstreamer.homepage
  version Gstreamer.version
  license Gstreamer.license
  compatibility Gstreamer.compatibility

  is_fake

  depends_on 'gstreamer'
end
