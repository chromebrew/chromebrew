require 'package'

class Appstream_glib < Package
  description 'Objects and methods for reading and writing AppStream metadata'
  homepage 'https://people.freedesktop.org/~hughsient/appstream-glib/'
  version '0.7.18-dbd6'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/hughsie/appstream-glib/archive/dbd62f6e054aab8ad8fd36a81023a247fdd543d8.zip'
  source_sha256 'e6532620fde20df56d121f692ab24a28a4389b2aa37d5199d676eda37baf1fd4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.7.18-dbd6_armv7l/appstream_glib-0.7.18-dbd6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.7.18-dbd6_armv7l/appstream_glib-0.7.18-dbd6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.7.18-dbd6_i686/appstream_glib-0.7.18-dbd6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.7.18-dbd6_x86_64/appstream_glib-0.7.18-dbd6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e917ad02dce4cfcf29f82a6f5a6af91bb1d26493aefeec0a14ecaf71c274821c',
     armv7l: 'e917ad02dce4cfcf29f82a6f5a6af91bb1d26493aefeec0a14ecaf71c274821c',
       i686: 'eb36d8dc0e3543d23b6c9a0ec4f05b246f9b6552882a6c387e79a05eaaea72af',
     x86_64: 'bde94624a342e2db10151ec317e0d719a99638e76385be0b42f4b691f19949d5'
  })

  depends_on 'cairo'
  depends_on 'docbook'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gcab'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libstemmer'
  depends_on 'libuuid'
  depends_on 'libyaml'
  depends_on 'pango'
  depends_on 'util_linux'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
