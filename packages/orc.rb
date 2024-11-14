require 'package'
Package.load_package("#{__dir__}/gstreamer.rb")

class Orc < Package
  description 'Optimized Inner Loop Runtime Compiler. Bundled with gstreamer.'
  homepage 'https://gitlab.freedesktop.org/gstreamer/orc'
  version Gstreamer.version
  license Gstreamer.license
  compatibility Gstreamer.compatibility

  is_fake

  depends_on 'gstreamer'
end
