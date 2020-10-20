require 'package'

class Appstream_glib < Package
  description 'This library provides objects and helper methods to help reading and writing AppStream metadata.'
  homepage 'https://github.com/hughsie/appstream-glib'
  version '0.7.18'
  compatibility 'all'
  source_url 'https://people.freedesktop.org/~hughsient/appstream-glib/releases/appstream-glib-0.7.18.tar.xz'
  source_sha256 'ca1ed22e3bde3912cb903aaa7de085d55771da454f1c0573fd9608e1de9c4002'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/appstream_glib-0.7.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fb88bafd2af9c6ee4c41a66b9f1004e57894dfe29d26a7fa04f38618e19a10f8',
     armv7l: 'fb88bafd2af9c6ee4c41a66b9f1004e57894dfe29d26a7fa04f38618e19a10f8',
       i686: '060c3a65ddaecbb8db18d84f58676ec56c390ec3d30dcba1580acf94981d0f40',
     x86_64: 'e3d8b538cd64ef79b4efd8c77142f1b6de1b861072ca5d9d5441effe66aac846',
  })

  depends_on 'docbook' => :build
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gperf'
  depends_on 'gtk_doc' => :build
  depends_on 'gtk3'
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libsoup'
  depends_on 'libarchive'
  depends_on 'libuuid'
  depends_on 'libstemmer'
  depends_on 'libyaml'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Dbuilder=false -Dman=false -Drpm=false _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
