require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '11.1'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-11.1.tar.xz'
  source_sha256 'f2521c525a77166189e3cb9169f75c2ee2b82fa3fcf9476024fbc2c3a6c9cd9e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '28ac4cfa32ca97dbd51cf678bfdc3f98e4eb4939bbf5bffc256f7021577d1bcf',
     armv7l: '28ac4cfa32ca97dbd51cf678bfdc3f98e4eb4939bbf5bffc256f7021577d1bcf',
       i686: '61cfd90e78fc8bb5c7a2422d3026883dae1f7efbb00e090946b58b2b365f0f42',
     x86_64: '67608beaffd35ca0f5a3c35769797d2eae4193d5c81c8cad5e6e123f2d667e44',
  })

  depends_on 'alsa_plugins'
  depends_on 'dbus'
  depends_on 'intltool'
  depends_on 'libsndfile'
  depends_on 'libatomic_ops'
  depends_on 'speexdsp'
  depends_on 'libcap'
  depends_on 'libtool'
  depends_on 'jsonc'
  depends_on 'gettext'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-x11"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
