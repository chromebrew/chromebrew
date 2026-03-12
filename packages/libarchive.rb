require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.6-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 '8ac57c1f5e99550948d1fe755c806d26026e71827da228f36bef24527e372e6f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2157f9f63c51f62b5ca84f5b5e6a031ea3965d57809dfcdb488c5e70b703c7d6',
     armv7l: '2157f9f63c51f62b5ca84f5b5e6a031ea3965d57809dfcdb488c5e70b703c7d6',
       i686: '93b9a3c033c6ec9eb3192a26630bd49802efa95855671d1e81139b4682f4d75c',
     x86_64: '939b2fe23b232a0b70dbb5432ec32de5aade50f63df56609e84cd449dbe38553'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  cmake_options '-DENABLE_TEST=OFF'

  cmake_install_extras do
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
