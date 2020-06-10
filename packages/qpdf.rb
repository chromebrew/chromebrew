require 'package'

class Qpdf < Package
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'http://qpdf.sourceforge.net/'
  version '7.1.1'
  compatibility 'all'
  source_url 'https://github.com/qpdf/qpdf/archive/release-qpdf-7.1.1.tar.gz'
  source_sha256 '21822dc365eaee55bc449d84eb760b9845c4871783ab0e4c4f3b244052718a1a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94947bdabca20ed079672c86ce3f6b94ff5e3d992e0d94d41cbeef7bbc40d78e',
     armv7l: '94947bdabca20ed079672c86ce3f6b94ff5e3d992e0d94d41cbeef7bbc40d78e',
       i686: 'c0bc260a6c702e6edc13cccf8294b257bf560d7e6977030aeddaf64606372668',
     x86_64: '32069b9fb1bcb81e9024eef707b5ab9e61bacc87fa8141f8de51ba4293fefa98',
  })
  
  depends_on 'libjpeg'
  depends_on 'automake' => :build

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
