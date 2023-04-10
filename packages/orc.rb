require 'package'
require_relative 'gstreamer'

class Orc < Package
  description 'Optimized Inner Loop Runtime Compiler. Bundled with gstreamer.'
  homepage 'https://gitlab.freedesktop.org/gstreamer/orc'
  version Gstreamer.version.to_s
  license Gstreamer.license.to_s
  compatibility Gstreamer.compatibilty.to_s

  is_fake

  depends_on 'gstreamer'
end
