require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '13.0'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-13.0.tar.xz'
  source_sha256 '961b23ca1acfd28f2bc87414c27bb40e12436efcf2158d29721b1e89f3f28057'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aa7b56bcd26e70751a4cbc8dcfb9f5c6e875787d2000845d17915e93af873d1f',
     armv7l: 'aa7b56bcd26e70751a4cbc8dcfb9f5c6e875787d2000845d17915e93af873d1f',
       i686: '8da3c531177e998b0460f9955721531bb54c1c6a94497f7ce4ecdbd4c3ac1dfd',
     x86_64: 'a6cb37e2bbf484eae8c3752bbc26c9092210a6401b5a86ccef5d0f683193f6c5',
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
