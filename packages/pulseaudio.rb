require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '12.2'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-12.2.tar.xz'
  source_sha256 '809668ffc296043779c984f53461c2b3987a45b7a25eb2f0a1d11d9f23ba4055'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gsettings_desktop_schemas'
  depends_on 'tcpwrappers'
  depends_on 'alsa_plugins' => :build
  depends_on 'tcpwrappers'
  depends_on 'libsndfile'
  depends_on 'intltool'
  depends_on 'xorg_lib'
  depends_on 'libgconf'
  depends_on 'gettext'
  depends_on 'libsoxr'
  depends_on 'libcap'
  depends_on 'jsonc'
  depends_on 'speex'
  depends_on 'eudev'
  depends_on 'gtk3'
  depends_on 'dbus'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
