require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'http://www.libarchive.org/'
  version '3.3.2'
  source_url 'http://www.libarchive.org/downloads/libarchive-3.3.2.tar.gz'
  source_sha256 'ed2dbd6954792b2c054ccf8ec4b330a54b85904a80cef477a1c74643ddafa0ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '06a0fd7aeaa505d75963286eb61302915b421a824aeec0237f4d6efed4f4f671',
     armv7l: '06a0fd7aeaa505d75963286eb61302915b421a824aeec0237f4d6efed4f4f671',
       i686: 'c902c5e75b4a7de6bc027fe971bb963957ed752e79dc6306734b2c1f3b0bab5b',
     x86_64: '55d1f9d949edad46042e0a268c19cebc2398fc8711c99b1071e089d7588ccfef',
  })

  depends_on 'acl'
  depends_on 'attr'
  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
