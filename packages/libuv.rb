require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  @_ver = '1.42.0'
  version @_ver
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{@_ver}/libuv-v#{@_ver}.tar.gz"
  source_sha256 '43129625155a8aed796ebe90b8d4c990a73985ec717de2b2d5d3a23cfe4deb72'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_armv7l/libuv-1.42.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_armv7l/libuv-1.42.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_i686/libuv-1.42.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_x86_64/libuv-1.42.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '852d208cc9a612e5030b75c67921bb72e25cd5b8305541d18d44142c90095eae',
     armv7l: '852d208cc9a612e5030b75c67921bb72e25cd5b8305541d18d44142c90095eae',
       i686: '3a03a2ad4792ee2f590c3007e18c0891318c2825e2c4bfae3b3bf22aae6632e2',
     x86_64: 'cb60ff3571ac0114354502698fcd4dea13c3f672ec3e1224587ced702df9e4fc'
  })

  def self.build
    system './autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
