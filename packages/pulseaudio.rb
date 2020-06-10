require 'package'

class Pulseaudio < Package
  description 'PulseAudio is a sound system for POSIX OSes, meaning that it is a proxy for your sound applications.'
  homepage 'https://www.freedesktop.org/wiki/Software/PulseAudio/'
  version '13.0-1'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/pulseaudio/releases/pulseaudio-13.0.tar.xz'
  source_sha256 '961b23ca1acfd28f2bc87414c27bb40e12436efcf2158d29721b1e89f3f28057'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pulseaudio-13.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b716830733de485cc75e7cacdc67a75210b76aa9efde63ca60c4c16bea22d6fe',
     armv7l: 'b716830733de485cc75e7cacdc67a75210b76aa9efde63ca60c4c16bea22d6fe',
       i686: '9dd90bb5103bea3aa384dbb3223e39ed64db0aeef98bae4455bc3ec915c3b21b',
     x86_64: '0cddede21a0f1c4d4f637eed06e808058f76533681f9d0161f788a9951cef68e',
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
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_DIR}/lib", "#{CREW_DEST_PREFIX}/libexec"
  end

  def self.check
    system 'make', 'check'
  end
end
