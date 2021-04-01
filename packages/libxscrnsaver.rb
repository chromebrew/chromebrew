require 'package'

class Libxscrnsaver < Package
  description 'X11 Screen Saver extension library'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver'
  version '1.2.3'
  license 'MIT'
  compatibility 'all'

  is_fake

  depends_on 'libxss'
end
