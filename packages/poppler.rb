require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.59.0'
  source_url 'https://poppler.freedesktop.org/poppler-0.59.0.tar.xz'
  source_sha256 'a3d626b24cd14efa9864e12584b22c9c32f51c46417d7c10ca17651f297c9641'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.59.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.59.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.59.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.59.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1f24358e86018b71bea4b92a1370491c87c5b6012db3c462dadefeab303a9649',
     armv7l: '1f24358e86018b71bea4b92a1370491c87c5b6012db3c462dadefeab303a9649',
       i686: 'fca9cb4e5b28525ef99194bc525d6e098f6df836abd7a053ff8974b8324bcee7',
     x86_64: '0bd38e54da87720cd5fa6d7471575795cead55d6b2b9942efaa96822caa880ef',
  })

  depends_on 'automake' => :build
  depends_on 'cairo'
  depends_on 'harfbuzz'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'openjpeg'
  depends_on 'zlibpkg'

  def self.build
    system "sed -i 's,/usr/local/lib,#{CREW_LIB_PREFIX},g' configure"
    system "sed -i 's,/usr/local/lib,#{CREW_LIB_PREFIX},g' m4/libtool.m4"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
