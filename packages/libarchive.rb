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
    aarch64: 'ccd5d2cb8f8d7cc5ddc1884b0f82de3fd96ed2a28e7811daeb39206985aea986',
     armv7l: 'ccd5d2cb8f8d7cc5ddc1884b0f82de3fd96ed2a28e7811daeb39206985aea986',
       i686: 'f59c46f28e71f97fa471df48e984e703a5edc7b6800fbe2f966b7b6b77cc2f8a',
     x86_64: '15e5a5c6cf69f7d41bd96f29068407854ab4b7bcc738b686bd2302552cff338f'
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
