require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.7-1'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.7.tar.bz2'
  source_sha256 'a74b405ab6d9e346e6908a853d5e7631cc61038d9b265bc7f37fab16e827da47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a0c67e36abf9d2dfc3d7da7b53c7ed14734e8545fc44fb77073bfbc0f8592fa',
     armv7l: '5a0c67e36abf9d2dfc3d7da7b53c7ed14734e8545fc44fb77073bfbc0f8592fa',
       i686: '7cb449d186acc168056cbfaf63b4c4942abc14475ce9d5f2b1fd6671f7226b3d',
     x86_64: '00d5ec8f220e64b9f4197b4897326192c963da616541d4787723a3969f2a129a',
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
sed -i 's,/usr/local/lib,#{CREW_LIB_PREFIX},g' \$f
sed -i 's,/usr/local,#{CREW_PREFIX},g' \$f
done"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
