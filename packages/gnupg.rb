require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.2.4'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.4.tar.bz2'
  source_sha256 '401a3e64780fdfa6d7670de0880aa5c9d589b3db7a7098979d7606cec546f2ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e981d7102f3f88f1c4fdc7f372bc3d039bff0ba08c7df202988d5a2cd282fad7',
     armv7l: 'e981d7102f3f88f1c4fdc7f372bc3d039bff0ba08c7df202988d5a2cd282fad7',
       i686: '63e324b9028bead6579d74aa9cd5659db5565b9716cbfb23bec2db02151ba1c6',
     x86_64: 'd509a69db73fd0bc69d177f6254a81519a19e9aafc2241d15d2e8237371aa8f8',
  })

  depends_on 'automake' => :build
  depends_on 'bz2'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'

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
