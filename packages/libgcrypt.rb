require 'package'

class Libgcrypt < Package
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.7.6'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.7.6.tar.bz2'
  source_sha256 '626aafee84af9d2ce253d2c143dc1c0902dda045780cc241f39970fc60be05bc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libgcrypt-1.7.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libgcrypt-1.7.6-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libgcrypt-1.7.6-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libgcrypt-1.7.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3e3de169b45e035bbb95032d5737e46d972b88a1e707ca0db19eda74c4fda498',
     armv7l: '3e3de169b45e035bbb95032d5737e46d972b88a1e707ca0db19eda74c4fda498',
       i686: '8d9412bc5847ef34b563427bfc930f3bfb503b81c017f796f65c0de54e0d850c',
     x86_64: '08d0ee064afb5643f69541875a2e5f4ed550ab4018f5d18a88897f016904568b',
  })

  depends_on 'libgpgerror'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
