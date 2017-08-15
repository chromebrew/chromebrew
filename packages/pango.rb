require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.40.9'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.40/pango-1.40.9.tar.xz'
  source_sha256 '9faea6535312fe4436b93047cf7a04af544eb52a079179bd3a33821aacce7e16'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pango-1.40.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pango-1.40.9-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pango-1.40.9-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pango-1.40.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '60fb01a75558724abfbd879cef6877fca2ca17d802abeca7c487bb9d8b75a08c',
     armv7l: '60fb01a75558724abfbd879cef6877fca2ca17d802abeca7c487bb9d8b75a08c',
       i686: 'c24290af6d40c9fe1b9797942941e5a181533574188678b8f1f6f6a9ea319ba4',
     x86_64: 'c90a74dcba01ac1731aca5879b5b54dc9e1c49c3f61ec5f2861384db2bafa4eb',
  })

  depends_on 'harfbuzz'
  depends_on 'cairo'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
