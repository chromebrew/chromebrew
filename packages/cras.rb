require 'package'

class Cras < Package
  description 'ChromeOS Audio Server'
  homepage 'https://www.chromium.org/chromium-os/chromiumos-design-docs/cras-chromeos-audio-server'
  version 'stabilize-12249.B'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/adhd/+/refs/heads/stabilize-12249.B/cras/README?format=TEXT'
  source_sha256 'b65b959f4ad842a219a637413b8702676378a0b5d18b5e413c78c211b3fb133c'

  depends_on 'alsa_lib'
  depends_on 'ladspa'
  depends_on 'iniparser'
  depends_on 'speexdsp'
  depends_on 'sbc'
  depends_on 'dbus'

  def self.build
    system 'git', 'clone', 'https://chromium.googlesource.com/chromiumos/third_party/adhd', '-b', version, '.'
    Dir.chdir('cras') do
      system 'cat << _EOF_ > 10-cras.conf
pcm.cras {
    type cras
    hint {
        show on
        description "Chromium OS Audio Server"
    }
}
ctl.cras {
    type cras
}
# Default: route all audio through the CRAS plugin.
pcm.!default {
    type cras
    hint {
        show on
        description "Default ALSA Output (currently Chromium OS Audio Server)"
    }
}
ctl.!default {
    type cras
}
_EOF_'
      system './git_prepare.sh'
      system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--disable-static',
             '--disable-webrtc-apm',
             '--enable-sse42',
             '--enable-avx',
             '--enable-avx2',
             '--enable-fma'
      system 'make'
    end
  end

  def self.install
    Dir.chdir('cras') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "install"
      FileUtils.mkdir_p CREW_DEST_PREFIX + '/share/alsa/alsa.conf.d/'
      FileUtils.install '10-cras.conf', CREW_DEST_PREFIX + '/share/alsa/alsa.conf.d/'
    end
  end
end
