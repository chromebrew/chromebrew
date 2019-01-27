require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.8'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.8.tar.bz2'
  source_sha256 '7f77df171685ccec918268477623a39db4d9f32d5dc5e76874ef2467a2405994'

  binary_url ({
  })
  binary_sha256 ({
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

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
