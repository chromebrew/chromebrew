require 'buildsystems/cmake'

class Tesseract < CMake
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  version '5.4.1-icu75.1'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/tesseract-ocr/tesseract.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8594813df34ba63b51026dd0b4c5b0322d03edbbbb23759164f093d44e7a0aca',
     armv7l: '8594813df34ba63b51026dd0b4c5b0322d03edbbbb23759164f093d44e7a0aca',
     x86_64: '0e11215ea37e12710713a2f1c6967485ebdb09ca771f84287cce7a4030cd7d9b'
  })

  depends_on 'acl' => :build
  depends_on 'asciidoc' => :build
  depends_on 'attr' => :build
  depends_on 'brotli' => :build
  depends_on 'bzip2' => :build
  depends_on 'cairo' # R
  depends_on 'c_ares' => :build
  depends_on 'curl' # R
  depends_on 'docbook_xsl' => :build
  depends_on 'e2fsprogs' => :build
  depends_on 'expat' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' => :build
  depends_on 'leptonica' # R
  depends_on 'libarchive' # R
  depends_on 'libcyrussasl' => :build
  depends_on 'libdeflate' => :build
  depends_on 'libidn2' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libnghttp2' => :build
  depends_on 'libpng' # R
  depends_on 'libpsl' => :build
  depends_on 'libssh' => :build
  depends_on 'libtiff' # R
  depends_on 'libunistring' => :build
  depends_on 'libwebp' # R
  depends_on 'libxml2' => :build
  depends_on 'lz4' => :build
  depends_on 'openjpeg' # R
  depends_on 'openldap' => :build
  depends_on 'openmp' => :build
  depends_on 'openssl' => :build
  depends_on 'pango' # R
  depends_on 'xzutils' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' => :build

  git_fetchtags

  cmake_options "-DBUILD_SHARED_LIBS=ON \
        -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} \
        -DENABLE_LTO=ON \
        -DENABLE_NATIVE=ON \
        -DOPENMP_BUILD=ON \
        -DUSE_SYSTEM_ICU=ON"
end
