require 'package'

class Lzma < Package
  description 'LZMA Utils are legacy data compression software with high compression ratio.'
  homepage 'https://tukaani.org/lzma/'
  version '4.32.7'
  source_url 'https://tukaani.org/lzma/lzma-4.32.7.tar.bz2'
  source_sha256 '618e54513993b3a153fa1c150fccdf25788c72b36e84ab4db71911083531cf6a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzma-4.32.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6de4cd3976b06fe144d92a2abeb2f8924df65a353b6cf0d76f5da0aa97188c32',
     armv7l: '6de4cd3976b06fe144d92a2abeb2f8924df65a353b6cf0d76f5da0aa97188c32',
       i686: 'a7262e79b86793ccab69c8cb787fad3b5193dc6715134904adf1b40ceda6f7ab',
     x86_64: '807699df57e6feda914ab0aaef80c15e4fc57e7ad75c0c76e79d5ef7eaabfc26',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln -s #{CREW_LIB_PREFIX}/liblzmadec.la #{CREW_DEST_LIB_PREFIX}/liblzma.la"
  end
end
