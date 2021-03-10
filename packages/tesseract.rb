require 'package'

class Tesseract < Package
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  @_ver = '4.1.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/tesseract-ocr/tesseract/archive/#{@_ver}.tar.gz"
  source_sha256 '2a66ff0d8595bff8f04032165e6c936389b1e5727c3ce5a27b3e059d218db1cb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tesseract-4.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tesseract-4.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tesseract-4.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tesseract-4.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2784bfad438508abf959d5cf40c2cb7bad39ad30338cf94bc1b2cc2cdc4a4f5c',
     armv7l: '2784bfad438508abf959d5cf40c2cb7bad39ad30338cf94bc1b2cc2cdc4a4f5c',
       i686: '019d1cd38b1008e43e022b147a1b34ab11c11da1622733b7abea681215557ab3',
     x86_64: '1661e2e92aeee9071cf37cee949a3c4d686fc379809e227be6e4b513b3a6b5f8'
  })

  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libjpeg_turbo'
  depends_on 'giflib'
  depends_on 'leptonica'
  depends_on 'cairo' => ':build'
  depends_on 'pango' => ':build'
  depends_on 'asciidoc' => ':build'

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "[ -f Makefile ] || env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -fno-math-errno -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -fno-math-errno -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
    system 'make training'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "make DESTDIR=#{CREW_DEST_DIR} training-install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tessdata"
    system "curl -Ls https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata -o #{CREW_DEST_PREFIX}/share/tessdata/osd.traineddata"
  end
end
