require 'package'

class Musl_libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  @_ver = '1.0'
  version "#{@_ver}-1"
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libunistring/libunistring-1.0.tar.xz'
  source_sha256 '5bab55b49f75d77ed26b257997e919b693f29fd4a1bc22e0e6e024c246c72741'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '652ce2e2858bffb5a9561c444882c182b0970fa3efcedc815ed8c2fdbedb8ea2',
     armv7l: '652ce2e2858bffb5a9561c444882c182b0970fa3efcedc815ed8c2fdbedb8ea2',
       i686: '00ad64cfae2ef01ce183c65f56ab1753b6ff3db16c51ab4625f953c24fa5c005',
     x86_64: 'e654273339a3cfff68899371dbbba287c5396184043b0dcdf249c10cff71fd6b'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_zlib' => :build

  is_musl
  is_static
  patchelf

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --enable-static \
        --enable-shared"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # avoid conflict with musl_libidn2
    FileUtils.rm_f "#{CREW_DEST_MUSL_PREFIX}/share/info/dir"
  end
end
