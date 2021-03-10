require 'package'

class Appstream_glib < Package
  description 'Objects and methods for reading and writing AppStream metadata'
  homepage 'https://people.freedesktop.org/~hughsient/appstream-glib/'
  version '0.7.18-1'
  compatibility 'all'
  source_url 'https://github.com/hughsie/appstream-glib/archive/appstream_glib_0_7_18.tar.gz'
  source_sha256 '73b8c10273c4cdd8f6de03c2524fedad64e34ccae08ee847dba804bb15461f6e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '88ca689a99806c8b5f8a5c23462ada7b13fd82d438a584d882e75b85d78e1a32',
     armv7l: '88ca689a99806c8b5f8a5c23462ada7b13fd82d438a584d882e75b85d78e1a32',
       i686: 'f67b2a08196652dc38c067a4bbf902891bb48ccf009eb6ba66c945766b579db8',
     x86_64: '31fc4c20d8c02a96c479d5e4e17bbb5afda0e671a5ac0dda1a254efd7d606893'
  })

  depends_on 'docbook'
  depends_on 'gcab'
  depends_on 'gdk_pixbuf'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gperf' => ':build'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => ':build'
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libsoup'
  depends_on 'libstemmer'
  depends_on 'libuuid'
  depends_on 'libyaml'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=true \
      -Drpm=false \
      builddir"
    system 'meson configure builddir'
    system "sed -i 's#-R#-Wl,-rpath=#g' builddir/build.ninja"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
