require 'package'

class Tesseract < Package
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  @_ver = '4.1.1'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/tesseract-ocr/tesseract/archive/#{@_ver}.tar.gz"
  source_sha256 '2a66ff0d8595bff8f04032165e6c936389b1e5727c3ce5a27b3e059d218db1cb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-1_armv7l/tesseract-4.1.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-1_armv7l/tesseract-4.1.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-1_i686/tesseract-4.1.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-1_x86_64/tesseract-4.1.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5ebd835d7e56c61c2718e2514c31a66742ab12ae419ee640dfe30e4dca9092e9',
     armv7l: '5ebd835d7e56c61c2718e2514c31a66742ab12ae419ee640dfe30e4dca9092e9',
       i686: '77cc9f2d88850fb4722cd0f2b924a1f3f6e74eb47b0cbdcf01394c80c4453991',
     x86_64: '78ba50689c80dfda47a0c21171576fb4613481558a63e3eda56c714432bdaa13'
  })

  depends_on 'asciidoc' => :build
  depends_on 'cairo'
  depends_on 'cairo' => :build
  depends_on 'fontconfig'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'leptonica'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'pango'
  depends_on 'pango' => :build

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
    system "curl -Ls https://github.com/tesseract-ocr/tessdata/raw/4767ea922bcc460e70b87b1d303ebdfed0897da8/eng.traineddata -o #{CREW_DEST_PREFIX}/share/tessdata/osd.traineddata"
  end
end
