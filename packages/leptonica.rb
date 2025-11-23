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
    aarch64: '9293c5934af118d2ab4282ad14871d4b3113da58df5f207b3761a3cffddf4cea',
     armv7l: '9293c5934af118d2ab4282ad14871d4b3113da58df5f207b3761a3cffddf4cea',
     x86_64: '8aec7395faa2f5de04c495fd9a96d7874b97ee6221b726bd715f2fb172f53b9d'
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
