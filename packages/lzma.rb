require 'package'

class Lzma < Package
  description 'LZMA Utils are legacy data compression software with high compression ratio.'
  homepage 'https://tukaani.org/lzma/'
  version '4.32.7-1'
  compatibility 'all'
  source_url 'https://tukaani.org/lzma/lzma-4.32.7.tar.bz2'
  source_sha256 '618e54513993b3a153fa1c150fccdf25788c72b36e84ab4db71911083531cf6a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb62ba6e36b24cf50d0490e3ed9c35c35a76ca394f98e6c572bf3e49ab48f205',
     armv7l: 'cb62ba6e36b24cf50d0490e3ed9c35c35a76ca394f98e6c572bf3e49ab48f205',
       i686: '73b723ede8d112ff824f7ab62bb5108f711d0a0cad6daf9472d2303b634e1516',
     x86_64: 'c8a08a86689baf36796baa5c86c1507b10b0b5cdaca733737be6c59782b07b1a',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
