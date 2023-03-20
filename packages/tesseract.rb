require 'package'

class Tesseract < Package
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  @_ver = '5.2.0'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/tesseract-ocr/tesseract.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.2.0-1_armv7l/tesseract-5.2.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.2.0-1_armv7l/tesseract-5.2.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.2.0-1_i686/tesseract-5.2.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.2.0-1_x86_64/tesseract-5.2.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '350272935abbf6bfab1cc3b018243d2e9fa08677d27c2f2feeaac4d57bd75145',
     armv7l: '350272935abbf6bfab1cc3b018243d2e9fa08677d27c2f2feeaac4d57bd75145',
       i686: 'b40e7e19174f21b38abc0695cd1821d31d1819f4d044d76d716ad724f22f0783',
     x86_64: 'd5fe0ec1764be79709c7ee4103a0084c313fbaa433f2a0b2a2ad98a8c30527c6'
  })

  depends_on 'asciidoc' => :build
  depends_on 'cairo'
  depends_on 'docbook_xsl' => :build
  depends_on 'fontconfig'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'leptonica'
  depends_on 'libarchive'
  depends_on 'curl'
  depends_on 'libjpeg'
  depends_on 'openldap'
  depends_on 'harfbuzz'
  depends_on 'libtiff'
  depends_on 'pango'
  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'brotli' # R
  depends_on 'bz2' # R
  depends_on 'c_ares' # R
  depends_on 'e2fsprogs' # R
  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libdeflate' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpng' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunistring' # R
  depends_on 'libwebp' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openjpeg' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R
  git_fetchtags

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system 'filefix'
    system "[ -f Makefile ] || #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    # XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog does not get set
    # in the Makefile without this, which results in errors at install
    system "find . -name 'Makefile' -exec sed -i 's,XML_CATALOG_FILES = ,XML_CATALOG_FILES = #{CREW_PREFIX}/etc/xml/catalog,g' {} +"
    system 'make || make'
    system 'make training'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "make DESTDIR=#{CREW_DEST_DIR} training-install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tessdata"
    system "curl -Ls https://github.com/tesseract-ocr/tessdata/blob/c2b2e0df86272ce11be323f23f96cf656565ed41/eng.traineddata -o #{CREW_DEST_PREFIX}/share/tessdata/osd.traineddata"
  end
end
