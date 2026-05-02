require 'buildsystems/autotools'

class Dbus_glib < Autotools
  description 'An obsolete, primarily unmaintained glib binding for libdbus.'
  homepage 'https://dbus.freedesktop.org/doc/dbus-glib/index.html'
  version '0.114'
  license 'GPL-2 or AFL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-#{version}.tar.gz"
  source_sha256 'c09c5c085b2a0e391b8ee7d783a1d63fe444e96717cc1814d61b5e8fc2827a7c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5250f9dfb4bd31afabc85a04983751fc042be77f8738f93f636a7d9fae11dfcd',
     armv7l: '5250f9dfb4bd31afabc85a04983751fc042be77f8738f93f636a7d9fae11dfcd',
     x86_64: 'dc681038fa4af936946d846be5da51c543a2f408e5eef29159e3b8b3bbfe4bf6'
  })

  depends_on 'dbus' => :library
  depends_on 'expat' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
end
