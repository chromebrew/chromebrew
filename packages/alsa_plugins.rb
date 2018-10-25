require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.7'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.7.tar.bz2'
  source_sha256 'a74b405ab6d9e346e6908a853d5e7631cc61038d9b265bc7f37fab16e827da47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1abb05f8e9fd533ee3d334b3572903cd191393a8ce96d4fb3158574580874571',
     armv7l: '1abb05f8e9fd533ee3d334b3572903cd191393a8ce96d4fb3158574580874571',
       i686: 'caa7cb34ef9b3817cd045e4bd528f02662f32ff9c5b613ffefc3e169d934e062',
     x86_64: '7cba5116274f0988618eceeb11e9cfebef90805e1ba6aec2b402c486ca68dbd9',
  })

  depends_on 'alsa_lib'
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
