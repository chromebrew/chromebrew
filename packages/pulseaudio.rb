require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '13.99.3'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-13.99.3.tar.gz'
  source_sha256 '2572543a7686c699654c40ec3945a598e6af50ff703f60de0446b7fbcd16ef01'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ed785bbf45af02e5a96ed947740f1f5b055bdee39670f1006d15d6fd96876f24',
     armv7l: 'ed785bbf45af02e5a96ed947740f1f5b055bdee39670f1006d15d6fd96876f24',
       i686: '0e19e15a116395b9aa52977c3cd99c9e735d70365146435d54bdd9e300df7e3c',
     x86_64: 'f346f11c323de6019f1f1189db6398d12671db5b493b68c18b1617e177faff68',
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
  depends_on 'gdbm'
  depends_on 'tdb'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
