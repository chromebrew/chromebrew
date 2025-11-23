require 'buildsystems/cmake'

class Leptonica < CMake
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.org'
  version '1.87.0-pre1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/DanBloomberg/leptonica.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce467a8ce915951e6a579ef134bb92c9ed82e5b7000db9c65a81cfa2b3ec27cd',
     armv7l: 'ce467a8ce915951e6a579ef134bb92c9ed82e5b7000db9c65a81cfa2b3ec27cd',
     x86_64: '77166ed2e0b882ccabe95844007027a4907dce27bbcc67fb17b4107d6cae62c4'
  })

  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libdeflate' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'openjpeg' # R
  depends_on 'xzutils' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
