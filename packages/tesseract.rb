require 'package'

class Tesseract < Package
  description 'A neural net (LSTM) based OCR engine which is focused on line recognition & an older OCR engine which recognizes character patterns.'
  homepage 'https://github.com/tesseract-ocr/tesseract'
  @_ver = '4.1.1'
  version "#{@_ver}-2"
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/tesseract-ocr/tesseract/archive/#{@_ver}.tar.gz"
  source_sha256 '2a66ff0d8595bff8f04032165e6c936389b1e5727c3ce5a27b3e059d218db1cb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-2_armv7l/tesseract-4.1.1-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-2_armv7l/tesseract-4.1.1-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-2_i686/tesseract-4.1.1-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tesseract/4.1.1-2_x86_64/tesseract-4.1.1-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dd19e48f5511792037333cb2b6945c9dd37cc87233d815932cdbf8a43bb30d01',
     armv7l: 'dd19e48f5511792037333cb2b6945c9dd37cc87233d815932cdbf8a43bb30d01',
       i686: 'eb365e5d43659b1ea285aaf81db2dc9c520fb00248212dae571571ec0d5a3d60',
     x86_64: '611623a2484006193d0a9506cc277f5ffb39a6c8de9229663c6d81da984d2b45'
  })

  depends_on 'asciidoc' => :build
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'leptonica'
  depends_on 'libarchive'
  depends_on 'libcurl'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'pango'

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system 'filefix'
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
