require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '11.1'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-11.1.tar.xz'
  source_sha256 'f2521c525a77166189e3cb9169f75c2ee2b82fa3fcf9476024fbc2c3a6c9cd9e'

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
