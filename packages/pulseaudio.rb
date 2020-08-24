require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '13.99.1-1'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-13.99.1.tar.gz'
  source_sha256 '80d3a217567e6eb52234e638765f0e0e7fe8feee89c2e532a15250ed6a8bfd30'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.99.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa9ead7cf978e3d598f2795427638d10a7895ede724bd82256dd64c7f5e91544',
     armv7l: 'fa9ead7cf978e3d598f2795427638d10a7895ede724bd82256dd64c7f5e91544',
       i686: 'd05e537614795f8e03592b9a2b4a23c3980fc70888323ac08a4cae1b992bb856',
     x86_64: '58ed8261edea0ea1e276c548591f44476f36758edef831870f8d1e8820e13e9e',
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
