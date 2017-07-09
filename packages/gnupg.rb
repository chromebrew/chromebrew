require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.1.22'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.22.tar.bz2'
  source_sha256 '46716faf9e1b92cfca86609f3bfffbf5bb4b6804df90dc853ff7061cfcfb4ad7'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gnupg-2.1.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gnupg-2.1.22-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/gnupg-2.1.22-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/gnupg-2.1.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2b7537b77bda382df365a57f189c6f4fec9c5f23f96c9d1b67b9a85897ef6636',
     armv7l: '2b7537b77bda382df365a57f189c6f4fec9c5f23f96c9d1b67b9a85897ef6636',
       i686: '4303dbd05640fb7aadc13756759a3579114b0269a26ac23b6fecf2e137928682',
     x86_64: '2b179e778449964e11da501685b6e4fbd06fd5c36501a6dd36d78d7fea6b7e1f',
  })

  depends_on 'bz2'
  depends_on 'automake'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
