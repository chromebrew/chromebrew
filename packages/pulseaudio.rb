require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  @_ver = '14.2'
  version @_ver
  compatibility 'all'
  source_url "https://freedesktop.org/software/pulseaudio/releases/pulseaudio-#{@_ver}.tar.xz"
  source_sha256 '75d3f7742c1ae449049a4c88900e454b8b350ecaa8c544f3488a2562a9ff66f1'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-14.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5229ace51bc615012d3ad2d0e00a587344d036f911819a6c3929c693e94eec9c',
     armv7l: '5229ace51bc615012d3ad2d0e00a587344d036f911819a6c3929c693e94eec9c',
       i686: 'cd9fd9ba81591a09bfd175d461918a8724c5edfa6059abf545f78d24385a3677',
     x86_64: 'c9aff79692b3beb4d210f3ad3eef87ec92dd64480e476a0cf1808c2a7ef3a0c3'
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
  depends_on 'tdb'
  depends_on 'check' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dsystem_user=chronos \
    -Dsystem_group=cras \
    -Daccess_group=cras \
    -Dbluez5=false \
    -Dalsa=enabled \
    -Dudevrulesdir=#{CREW_PREFIX}/libexec/rules.d \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
