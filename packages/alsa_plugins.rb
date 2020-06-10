require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.2'
  compatibility 'all'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.2.2.tar.bz2'
  source_sha256 '1c0f06450c928d711719686c9dbece2d480184f36fab11b8f0534cb7b41e337d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6dfe0afc4137d689eda0c4693aac4016e66e9da74ccaf540ebd12cb2fd704103',
     armv7l: '6dfe0afc4137d689eda0c4693aac4016e66e9da74ccaf540ebd12cb2fd704103',
       i686: '2e363fbae56a4dc05af716316f6465b36655663a5953437af4c996e22eece8bc',
     x86_64: '2c0108843697c8711160defebbf6db421a2b6fe1aa582b9567e8cbb9b124bf02',
  })

  depends_on 'dbus'
  depends_on 'ffmpeg'
  depends_on 'speexdsp'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-alsalconfdir=#{CREW_PREFIX}/etc/alsa/conf.d"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
