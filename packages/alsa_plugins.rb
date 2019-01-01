require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.7-2'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.7.tar.bz2'
  source_sha256 'a74b405ab6d9e346e6908a853d5e7631cc61038d9b265bc7f37fab16e827da47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b287b4d7c2252ce45f7ac08fe8b123fd14c538c83f03fedf9a9af6cc3c14c49',
     armv7l: '9b287b4d7c2252ce45f7ac08fe8b123fd14c538c83f03fedf9a9af6cc3c14c49',
       i686: 'e8358822e27b9825cb8d115d197514ca4af5a97e4273b8266a0b9b64bbc2865a',
     x86_64: 'b8356d2d759e7d5079e36840f200dfde01c786a53b6f7f7ab2355734afe7acaa',
  })

  depends_on 'alsa_lib'
  depends_on 'libav'
  depends_on 'pulseaudio'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "for f in \$(find . -name Makefile); do
            sed -i 's,/etc/alsa,#{CREW_PREFIX}/etc/alsa,g' \$f
            sed -i 's,/usr/local,#{CREW_PREFIX},g' \$f; done"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
