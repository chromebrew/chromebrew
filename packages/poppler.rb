require 'buildsystems/cmake'

class Poppler < CMake
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '26.11.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/poppler/poppler.git'
  git_hashtag "poppler-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47f4bfbc4ee9dafed8ad0feb6013689f83f1d1279d5dcdce28fc72f3798f1b8e',
     armv7l: '47f4bfbc4ee9dafed8ad0feb6013689f83f1d1279d5dcdce28fc72f3798f1b8e',
     x86_64: 'd14e34397dc6f82c3f42b516093d7347d8e85953fd02ad0086d4359e0171775a'
  })

  depends_on 'boost' => :build
  depends_on 'brotli' => :library
  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gpgmepp' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'lcms' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'nss' => :library
  depends_on 'openjpeg' => :library
  depends_on 'poppler_data' => :build
  depends_on 'qt5_base' => :library
  depends_on 'zlib' => :library

  cmake_options '-DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
                 -DENABLE_QT6=OFF \
                 -DBUILD_QT6_TESTS=OFF'
end
