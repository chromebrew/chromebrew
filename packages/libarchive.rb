require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.4-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 'c7b847b57feacf5e182f4d14dd6cae545ac6843d55cb725f58e107cdf1c9ad73'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '193c9b327030b6619ab5d2f0a1ced145e24b6529efe86bbdc9bcce9e5b2f25f1',
     armv7l: '193c9b327030b6619ab5d2f0a1ced145e24b6529efe86bbdc9bcce9e5b2f25f1',
       i686: 'b167f91180460923cff4f7616556387e0722998a97bfbcf5bc235802882fd690',
     x86_64: 'd27cadab66206041dc445865b4022e1ab7cfaf773a0ba37c5ed8e03268a891cf'
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
