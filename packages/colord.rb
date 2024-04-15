require 'package'

class Colord < Package
  description 'colord is a system service that makes it easy to manage, install and generate color profiles to accurately color manage input and output devices.'
  homepage 'https://www.freedesktop.org/software/colord/'
  version '1.4.5'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://www.freedesktop.org/software/colord/releases/colord-#{version}.tar.xz"
  source_sha256 'b774ea443d239f4a2ee1853bd678426e669ddeda413dcb71cea1638c4d6c5e17'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '52e9192284622a986090b7c2b88fd888e0a338e212681f21f3df62dd69670554',
     armv7l: '52e9192284622a986090b7c2b88fd888e0a338e212681f21f3df62dd69670554',
     x86_64: '35bb9659086e6c86785609196d8aff86b008584ef139bb22644f71a5909d4ba8'
  })

  depends_on 'bash_completion'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'gusb'
  depends_on 'lcms'
  depends_on 'libgudev'
  depends_on 'polkit'
  depends_on 'vala'

  def self.patch
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} -Dsystemd=false -Ddaemon_user=#{USER} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
