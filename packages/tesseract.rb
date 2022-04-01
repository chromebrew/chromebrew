require 'package'

class Tesseract < Package
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  @_ver = '5.1.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/tesseract-ocr/tesseract.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.1.0_armv7l/tesseract-5.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.1.0_armv7l/tesseract-5.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.1.0_i686/tesseract-5.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/5.1.0_x86_64/tesseract-5.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '866199b054c0f0b73da596873330d161512a8c78be8f73157732aee7186887d3',
     armv7l: '866199b054c0f0b73da596873330d161512a8c78be8f73157732aee7186887d3',
       i686: 'aa036d11efbddd231af55bede9ac2a6cb3c97729727dbd4f1c572888f0e4f030',
     x86_64: '769d295e22bd108230cceab03b1ea3bc0daf88c6140166883e671339955f7566'
  })

  depends_on 'asciidoc' => :build
  depends_on 'harfbuzz'
  depends_on 'docbook_xsl' => :build
  depends_on 'fontconfig'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'leptonica'
  depends_on 'libarchive'
  depends_on 'libcurl'
  depends_on 'libjpeg'
  depends_on 'harfbuzz'
  depends_on 'libtiff'
  depends_on 'pango'
  git_fetchtags

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system 'filefix'
    system "[ -f Makefile ] || #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    # XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog does not get set
    # in the Makefile without this, which results in errors at install
    system "find . -name 'Makefile' -exec sed -i 's,XML_CATALOG_FILES = ,XML_CATALOG_FILES = #{CREW_PREFIX}/etc/xml/catalog,g' {} +"
    system 'make'
    system 'make training'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "make DESTDIR=#{CREW_DEST_DIR} training-install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tessdata"
    system "curl -Ls https://github.com/tesseract-ocr/tessdata/blob/c2b2e0df86272ce11be323f23f96cf656565ed41/eng.traineddata -o #{CREW_DEST_PREFIX}/share/tessdata/osd.traineddata"
  end
end
