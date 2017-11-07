require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.32.92'

  is_fake

  depends_on 'libwayland'
  depends_on 'wayland_protocols'
end
