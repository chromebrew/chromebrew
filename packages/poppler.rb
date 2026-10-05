require 'buildsystems/cmake'

class Poppler < CMake
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '26.10.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/poppler/poppler.git'
  git_hashtag "poppler-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2e869e700b15e6b2d3ef547a6713188b8da97d9ca7433c747abb0b6bfe261f3',
     armv7l: 'd2e869e700b15e6b2d3ef547a6713188b8da97d9ca7433c747abb0b6bfe261f3',
     x86_64: '73de16cff7675e5c7030aecac4e41c80088d90f02a10eb047dd83c38553c5135'
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
