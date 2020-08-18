require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '13.99.1'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-13.99.1.tar.gz'
  source_sha256 '961b23ca1acfd28f2bc87414c27bb40e12436efcf2158d29721b1e89f3f28057'

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
    system "./configure #{CREW_OPTIONS} -j#{CREW_NPROC}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
