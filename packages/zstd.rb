require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.0'
  version @_ver
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url "https://github.com/facebook/zstd/archive/v#{@_ver}.tar.gz"
  source_sha256 '0d9ade222c64e912d6957b11c923e214e2e010a18f39bec102f572e693ba2867'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0_armv7l/zstd-1.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0_armv7l/zstd-1.5.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0_i686/zstd-1.5.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0_x86_64/zstd-1.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ee8ce213f9209da69ed272c684cf20d1dcf75e24c1d7bfb11e1091b9484793c2',
     armv7l: 'ee8ce213f9209da69ed272c684cf20d1dcf75e24c1d7bfb11e1091b9484793c2',
       i686: 'a8d8312f83a0cdf627ceb5f9a6099e5036f20fbedd9a6c53c678b50c3d1a34c9',
     x86_64: '4da82c8d02a0f8b2a2e2591110708df8e36b9451631420de28a8c2d14f579265'
  })

  def self.build
    Dir.chdir 'build/meson' do
      system "meson \
        #{CREW_MESON_OPTIONS} \
        builddir"
      system 'meson configure builddir'
      system 'ninja -C builddir'
    end
  end

  def self.install
    Dir.chdir 'build/meson' do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    end
  end
end
