require 'buildsystems/cmake'

class Tesseract < CMake
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  version "5.5.1-#{CREW_ICU_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/tesseract-ocr/tesseract.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5cbcd2f6f5720300f973d75d1d990c2bb8754e1ed34dd02f3d092fa10978f17',
     armv7l: 'a5cbcd2f6f5720300f973d75d1d990c2bb8754e1ed34dd02f3d092fa10978f17',
     x86_64: '3b7d9afe7ce9e0f97f821fdbd0beb2b9f7016567c41f8a481c5b1c13328480c6'
  })

  depends_on 'acl' => :build
  depends_on 'attr' => :build
  depends_on 'brotli' => :build
  depends_on 'bzip2' => :build
  depends_on 'c_ares' => :build
  depends_on 'cairo' => :executable
  depends_on 'curl' => :library
  depends_on 'docbook_xml' => :build
  depends_on 'e2fsprogs' => :build
  depends_on 'expat' => :build
  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'giflib' # R
  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :executable
  depends_on 'icu4c' => :library
  depends_on 'krb5' => :build
  depends_on 'leptonica' => :library
  depends_on 'libarchive' => :library
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
  depends_on 'pango' => :executable
  depends_on 'py3_asciidoc' => :build
  depends_on 'xzutils' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' => :build

  git_fetchtags

  cmake_options '-DBUILD_SHARED_LIBS=ON \
        -DENABLE_LTO=ON \
        -DOPENMP_BUILD=ON \
        -DUSE_SYSTEM_ICU=ON'
end
