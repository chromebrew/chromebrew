require 'buildsystems/cmake'

class Leptonica < CMake
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.org'
  version '1.87.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/DanBloomberg/leptonica.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8524c29dded67c6587f8166a3e53bd59fafb6d27e40c94a0776ad9bcc932c1a7',
     armv7l: '8524c29dded67c6587f8166a3e53bd59fafb6d27e40c94a0776ad9bcc932c1a7',
     x86_64: '6209b8824d1900443e10ffa24113560cf56c9b3bdcdce6f913a15595a4ca5255'
  })

  depends_on 'giflib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :build
  depends_on 'libdeflate' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'openjpeg' => :library
  depends_on 'xzutils' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
