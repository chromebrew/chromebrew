require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.39.90.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.beta/sources/at-spi2-core-2.39.90.1.tar.xz'
  source_sha256 '2e8a9098e64dc66478ca095d3ca91657626eb778dc75e64bff6294be7ceaa4ba'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.90.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.90.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.90.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.90.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b29ccd5984ad407ca52ce7890e315ab9bbafcfc5eae1151f017385c8f5e181f8',
     armv7l: 'b29ccd5984ad407ca52ce7890e315ab9bbafcfc5eae1151f017385c8f5e181f8',
       i686: '6f90a42303579e980393fd221f39a8dddacd9dba601c9d24bfe46e50bc9e5b16',
     x86_64: '2e9227ff4ea9dcad67fce2b5de279d493a776b68df7fb5c9fbd3dae9aaa9c892'
  })

  depends_on 'libxtst'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'libxcb'
  depends_on 'gtk_doc'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
