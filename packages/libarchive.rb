require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.2-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 'db0dee91561cbd957689036a3a71281efefd131d35d1d98ebbc32720e4da58e2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17d4316dd6344d44850cf9780abe83f8190553cdea629c94faeeebcf46f48f04',
     armv7l: '17d4316dd6344d44850cf9780abe83f8190553cdea629c94faeeebcf46f48f04',
       i686: 'dcb155fa9a25da25a5264d89edf14727c7d711659a61eba1e3d0dec0fa451fb1',
     x86_64: 'a7b589445c33716d11b99370996167ccd08f1caa9a11f5ea81c074ed02e85873'
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
