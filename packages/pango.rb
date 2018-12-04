require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.42.4'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.42/pango-1.42.4.tar.xz'
  source_sha256 '1d2b74cd63e8bd41961f2f8d952355aa0f9be6002b52c8aa7699d9f5da597c9d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '071eb7577ceb4017efbb8c68fe4aab16bc247dddf66570b681de5e89a874902f',
     armv7l: '071eb7577ceb4017efbb8c68fe4aab16bc247dddf66570b681de5e89a874902f',
       i686: '3aad278555332b5733ef108e141ce1fd57a7d1d4c4e3ba4c15d9b6fa0a94b7d6',
     x86_64: '10caa80ccf8d2eaef71e48dcb8f9cacf971d66450562c490043dbe35da8ab252',
  })

  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'libxrender'
  depends_on 'fribidi'
  depends_on 'six'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-xft'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
