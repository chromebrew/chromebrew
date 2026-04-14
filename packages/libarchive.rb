require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.7-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 'd3a8ba457ae25c27c84fd2830a2efdcc5b1d40bf585d4eb0d35f47e99e5d4774'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6f0be7e1f42ebaa1c247acdeb215f51a10681b76d3b5eee6cae3888f2b2fd8e',
     armv7l: 'a6f0be7e1f42ebaa1c247acdeb215f51a10681b76d3b5eee6cae3888f2b2fd8e',
       i686: '939a4e51c0371e3184cd43d4e712a33d8fe884c40416374d2c015a10464c075a',
     x86_64: 'c27a691a93355dcd6206d8d84e0af5f78c70ad09ad76fe60fcdaddc51aa8d590'
  })

  depends_on 'acl' => :library
  depends_on 'attr' # R
  depends_on 'bzip2' => :library
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'icu4c' # R
  depends_on 'libxml2' => :library
  depends_on 'lz4' => :library
  depends_on 'openssl' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  cmake_options '-DENABLE_TEST=OFF'

  cmake_install_extras do
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
