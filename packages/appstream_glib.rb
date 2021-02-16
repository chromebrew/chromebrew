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
    aarch64: '64c32d204000c109d1b1d822bf510c9e96f0c0387c462604a2fa6f6da842180f',
     armv7l: '64c32d204000c109d1b1d822bf510c9e96f0c0387c462604a2fa6f6da842180f',
       i686: '8111ff1a640b4a5b9c6c0176a5b3cf4351f7d859a3953239555dcf6c1de16144',
     x86_64: '25a3e745b200df518a0b77bc5e9f7c1133a378a060329d5766167ce5a137c5f4',
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
