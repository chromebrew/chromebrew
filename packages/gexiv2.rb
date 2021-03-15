require 'package'

class Gexiv2 < Package
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  @_ver = '0.12.2'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gexiv2/#{@_ver_prelastdot}/gexiv2-#{@_ver}.tar.xz"
  source_sha256 '2322b552aca330eef79724a699c51a302345d5e074738578b398b7f2ff97944c'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gexiv2-0.12.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '305a56146c461035262b294710aacb8e5401d2bcee8e1828661e35e78b5bf47e',
     armv7l: '305a56146c461035262b294710aacb8e5401d2bcee8e1828661e35e78b5bf47e',
       i686: '278e97c62e7dbc3e8f68fffd8c7ac0802ddf07db1dd9f623ce309f598173db12',
     x86_64: '81500e05e77186cad22c4e000af94395e760b502913920245015417fae5ba94c'
  })

  depends_on 'libexiv2'
  depends_on 'gobject_introspection'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
