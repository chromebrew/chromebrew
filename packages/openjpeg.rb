require 'buildsystems/cmake'

class Openjpeg < CMake
  description 'An open source JPEG 2000 codec, written in C.'
  homepage 'https://github.com/uclouvain/openjpeg'
  version '2.5.4'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/uclouvain/openjpeg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e22a565ed03f1d81c9794c01a1e17b5610aac01a3f0942f61d55605ce631f0f1',
     armv7l: 'e22a565ed03f1d81c9794c01a1e17b5610aac01a3f0942f61d55605ce631f0f1',
     x86_64: '3f5122ee391a746dc4c0108968f8cafcc7cd507dd0f4eb1348b83b321d1e08d6'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jbigkit' => :library
  depends_on 'lcms' => :executable
  depends_on 'libdeflate' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libwebp' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  cmake_options "-DOPENJPEG_INSTALL_LIB_DIR='lib#{CREW_LIB_SUFFIX}'"
end
