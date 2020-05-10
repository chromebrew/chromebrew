require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.4.2'
  compatibility 'all'
  source_url 'https://www.libarchive.org/downloads/libarchive-3.4.2.tar.gz'
  source_sha256 'b60d58d12632ecf1e8fad7316dc82c6b9738a35625746b47ecdcaf4aed176176'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd84d0e6a0a8223863a24f0357a1a21a1eed520e7115fa377267d555de18e3190',
     armv7l: 'd84d0e6a0a8223863a24f0357a1a21a1eed520e7115fa377267d555de18e3190',
       i686: 'b650a66234e47f1cf4e5970c483cd4cebaed61ed6a177e45ad0480b61eb50811',
     x86_64: 'd8131fdd7605773a1f3955b2e9bc1649d67d00a1c034355f8561fb0cbb1bfe7c',
  })

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
