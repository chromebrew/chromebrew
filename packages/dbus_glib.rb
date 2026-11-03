require 'buildsystems/autotools'

class Dbus_glib < Autotools
  description 'An obsolete, primarily unmaintained glib binding for libdbus.'
  homepage 'https://dbus.freedesktop.org/doc/dbus-glib/index.html'
  version '0.116'
  license 'GPL-2 or AFL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-#{version}.tar.gz"
  source_sha256 'e3f3d4487e2883800770ed5899ed111bdc4ba7056af34a255c4c46ad8a2486f3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8773a29bed072d0e382a24785001d08595a48274ea7496fad8bc48c174e82376',
     armv7l: '8773a29bed072d0e382a24785001d08595a48274ea7496fad8bc48c174e82376',
     x86_64: '2cfde055e828c43be6b5ac220166e5848e212baba1a417ed21edfc4bc34ffabe'
  })

  depends_on 'dbus' => :library
  depends_on 'expat' => :executable
  depends_on 'expat' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
