require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '12.2'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-12.2.tar.xz'
  source_sha256 '809668ffc296043779c984f53461c2b3987a45b7a25eb2f0a1d11d9f23ba4055'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21e0c3de444978be9c7bebcbd43a318be18d5a34abda349c9a47ee73a7dd954c',
     armv7l: '21e0c3de444978be9c7bebcbd43a318be18d5a34abda349c9a47ee73a7dd954c',
       i686: '7885682021dd56ebca0bc50476a25b7b9f61032cf7d29c1db54f14be0becaecf',
     x86_64: '11ab10e4a08e5e701a085c20a5ca618f95089702b1c2a19dbba445ae7c41fd32',
  })

  depends_on 'gsettings_desktop_schemas'
  depends_on 'alsa_plugins' => :build
  depends_on 'tcpwrappers'
  depends_on 'libsndfile'
  depends_on 'xorg_lib'
  depends_on 'libgconf'
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
