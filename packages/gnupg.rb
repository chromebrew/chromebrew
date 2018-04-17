require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.2.5'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.5.tar.bz2'
  source_sha256 '3fa189a32d4fb62147874eb1389047c267d9ba088f57ab521cb0df46f08aef57'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '433aa56f0b8e547d14e65f0aa007fa8dcfbd2b9656052c5e232ef6b8fc269245',
     armv7l: '433aa56f0b8e547d14e65f0aa007fa8dcfbd2b9656052c5e232ef6b8fc269245',
       i686: '47ba8dab458b2a33f9b402bd4441ada0aae486b59e48e2658bf1537a95be58f1',
     x86_64: '26bb165f909b7482f680bd5bba57c76210543afb75c6be62c495a2f237c2e3c9',
  })

  depends_on 'automake' => :build
  depends_on 'bz2'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'
  depends_on 'pinentry'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
