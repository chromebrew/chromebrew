require 'package'

class Tesseract < Package
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  version '5.3.1'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/tesseract-ocr/tesseract.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.3.1_armv7l/tesseract-5.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.3.1_armv7l/tesseract-5.3.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.3.1_x86_64/tesseract-5.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7822dc17500f27a28b76ac88637578a262d3e6f5061f7e5c086535d0162eb378',
     armv7l: '7822dc17500f27a28b76ac88637578a262d3e6f5061f7e5c086535d0162eb378',
     x86_64: '98d8715bf3f19ac7c32bafb76d6664117ecb964d71f0c20bfcf33c4e913917b6'
  })

  depends_on 'acl' => :build
  depends_on 'asciidoc' => :build
  depends_on 'attr' => :build
  depends_on 'brotli' => :build
  depends_on 'bz2' => :build
  depends_on 'cairo' => :build
  depends_on 'c_ares' => :build
  depends_on 'curl' # R
  depends_on 'docbook_xsl' => :build
  depends_on 'e2fsprogs' => :build
  depends_on 'expat' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glib' => :build
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
  depends_on 'libjpeg' # R
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
  depends_on 'openssl' => :build
  depends_on 'pango' # R
  depends_on 'xzutils' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' => :build

  git_fetchtags

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} \
        -DENABLE_LTO=ON \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
