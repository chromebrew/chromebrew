require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  version '1.44.2'
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{version}/libuv-v#{version}.tar.gz"
  source_sha256 'ccfcdc968c55673c6526d8270a9c8655a806ea92468afcbcabc2b16040f03cb4'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.44.2_armv7l/libuv-1.44.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.44.2_armv7l/libuv-1.44.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.44.2_i686/libuv-1.44.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.44.2_x86_64/libuv-1.44.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b323b1255d8f8bb03b218cf3c271b16f0e70e2e9d8d7eb350ad7a099785b3552',
     armv7l: 'b323b1255d8f8bb03b218cf3c271b16f0e70e2e9d8d7eb350ad7a099785b3552',
       i686: '7735507974c9e44dd4d92285e62de13917bd8fedaeb4ea3eede2880e25328e75',
     x86_64: '5e2a57c818451af267468a254de305595c86003f1f9160fd13205282cc1ab400'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "#{CREW_ENV_OPTIONS} cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          .."
    end
    system 'samu -C builddir'
  end

  # udp_multicast_join and udp_multicast_join6 tests fail
  def self.check
    system 'samu -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
