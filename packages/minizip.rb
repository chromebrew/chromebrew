require 'package'

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage 'https://www.zlib.net/'
  @_ver = '1.2.11'
  # When upgrading minzip, be sure to upgrade zlibpkg in tandem.
  version @_ver
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.11_armv7l/minizip-1.2.11-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.11_armv7l/minizip-1.2.11-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.11_i686/minizip-1.2.11-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.11_x86_64/minizip-1.2.11-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9acca61b29f60f66e83e4216290b668f03d756ab59e642a7eca7ef6cedd36c2b',
     armv7l: '9acca61b29f60f66e83e4216290b668f03d756ab59e642a7eca7ef6cedd36c2b',
       i686: '27c54c27436820905d315f4d356619897f4beae737fd6ad849339166abb999d3',
     x86_64: '570539d195bfd82931407cf1e93610159cf8475265d703e9dc91953e5f1bc8da'
  })

  depends_on 'zlibpkg'

  def self.build
    Dir.chdir 'contrib/minizip' do
      system 'autoreconf -fiv'
      system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-demos"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'contrib/minizip' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
