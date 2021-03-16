require 'package'

class Folks < Package
  description 'Library to aggregates people into metacontacts'
  homepage 'https://wiki.gnome.org/Projects/Folks'
  @_ver = '0.15.2'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/folks/-/archive/#{@_ver}/folks-#{@_ver}.tar.bz2"
  source_sha256 'fc793ac48add708bf95b65060e74d66c016ea6077297f3329c59fee83cc415ed'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/folks-0.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/folks-0.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/folks-0.15.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/folks-0.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e6b4e6fe98522d67283e033a176c9efbb11784d0a5dd93c048a96418011fb64f',
     armv7l: 'e6b4e6fe98522d67283e033a176c9efbb11784d0a5dd93c048a96418011fb64f',
       i686: '96eff279765de921eeca9ea66dfc78b9885f65feac95d85a87bdf4dec8b94e51',
     x86_64: '304f648e3f5a0ea9cf558c435830cd172a118ce3b4bd96ab3b4958c3f9a8eb1b'
  })

  depends_on 'libgee'
  depends_on 'evolution_data_server'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'vala' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dbluez_backend=false \
    -Ddocs=false \
    -Deds_backend=false \
    -Dinstalled_tests=false \
    -Dofono_backend=false \
    -Dtelepathy_backend=false \
    -Dtests=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
