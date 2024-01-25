require 'buildsystems/cmake'

class Openjpeg < CMake
  description 'An open source JPEG 2000 codec, written in C.'
  homepage 'https://github.com/uclouvain/openjpeg'
  version '2.5.0'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.5.0.tar.gz'
  source_sha256 '0333806d6adecc6f7a91243b2b839ff4d2053823634d4f6ed7a59bc87409122a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7af46fa74fd908fafa8c9ba3761a5f3167159e7e0776d72892b342d130db604',
     armv7l: 'a7af46fa74fd908fafa8c9ba3761a5f3167159e7e0776d72892b342d130db604',
     x86_64: 'cad4bc6d4f0784d9f0871c51d36c5c96ff5becff4d43ed52eefda13c89ea5eeb'
  })

  depends_on 'glibc' # R
  depends_on 'jbigkit' # R
  depends_on 'libdeflate' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  cmake_options "-DOPENJPEG_INSTALL_LIB_DIR='lib#{CREW_LIB_SUFFIX}'"
end
