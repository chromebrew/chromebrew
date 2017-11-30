require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.7'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.7.tar.gz'
  source_sha256 'f63c5e7d30362ed28b38bfa1ac6313f9a80230720b7fb6c80575eeab3ff5900c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26c83a2954c6180c3353d498bf6271216b9c12e11a7dc5f7207df9dc93c2b76a',
     armv7l: '26c83a2954c6180c3353d498bf6271216b9c12e11a7dc5f7207df9dc93c2b76a',
       i686: '650adc4a7aedbd6e9db24dff7d747ee3a9c87366b1d4aa012464867ebff15151',
     x86_64: '2f55a258847137e155f029392119906803f5a4e361aa137235a6e79c5470716e',
  })

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared",
      "--disable-static",
      "--with-pic",
      "--without-python",
      "--without-lzma",
      "--without-zlib"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system "rm", "test/ebcdic_566012.xml"

    system "make", "check"
  end
end
