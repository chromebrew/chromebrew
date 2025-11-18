require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.3-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 '90e21f2b89f19391ce7b90f6e48ed9fde5394d23ad30ae256fb8236b38b99788'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f217dc4c7052b84f96133a4397ac86278335b1d2860d65e6a8e0fd86922f1be2',
     armv7l: 'f217dc4c7052b84f96133a4397ac86278335b1d2860d65e6a8e0fd86922f1be2',
       i686: '06be7d4c0d78cc3ed63f940e6de657ddde9f9860031a95e8f9999cfed044db18',
     x86_64: 'b196a7f6c6352b55f957dd807e34b6825cd8a8d115d86d4e5f3ebf1a5a33e255'
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
