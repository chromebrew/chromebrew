require 'package'

class Cras < Package
  description 'ChromeOS Audio Server'
  homepage 'https://www.chromium.org/chromium-os/chromiumos-design-docs/cras-chromeos-audio-server'
  version 'stabilize-13654.B'
  compatibility 'all'
  source_url "https://chromium.googlesource.com/chromiumos/third_party/adhd/+/refs/heads/#{version}/cras/README.md"
  source_sha256 '355514e78ba4d1736f53c427c329bdfad327afc052a1b78d543cb4840d199b4e'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cras-stabilize-13654.B-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cras-stabilize-13654.B-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/cras-stabilize-13654.B-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cras-stabilize-13654.B-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '586a93c5359b39c91a576904a212dde5926581d603263874d71feef6ef6cf1e2',
      armv7l: '586a93c5359b39c91a576904a212dde5926581d603263874d71feef6ef6cf1e2',
        i686: '4f488c0a8ca5115995c2d9530442c7ad58da8bb19684d75815c6b60d9ae8ed18',
      x86_64: '1f53ed96948e29f71d42f1b437e7e4637f6e08a4e573966ec139bb3437ed0d21',
  })


    depends_on 'alsa_lib'
    depends_on 'ladspa'
    depends_on 'iniparser'
    depends_on 'speexdsp'
    depends_on 'sbc'
    depends_on 'dbus'
    depends_on 'rust' => ':build'
    depends_on 'llvm' => ':build'
    depends_on 'gtest' => :build
    depends_on 'eudev'

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
      if ARCH == 'i686'
        system "CFLAGS='-fuse-ld=lld -msse2' ./configure #{CREW_OPTIONS} \
          --disable-alsa-plugin \
          --disable-webrtc-apm \
          --enable-sse42 \
          --enable-avx \
          --enable-avx2
          --enable-fma"
      else
        system "CFLAGS='-fuse-ld=lld' ./configure #{CREW_OPTIONS} \
          --disable-alsa-plugin \
          --disable-webrtc-apm \
          --enable-sse42 \
          --enable-avx \
          --enable-avx2 \
          --enable-fma"
      end
      system "make"
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
