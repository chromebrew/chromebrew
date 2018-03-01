require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.12.2'
  source_url 'https://www.cairographics.org/releases/cairomm-1.12.2.tar.gz'
  source_sha256 '45c47fd4d0aa77464a75cdca011143fea3ef795c4753f6e860057da5fb8bd599'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '716198def65f7a922c3731bdb67e11734bfe48ce88c1387babe397cf173803d9',
     armv7l: '716198def65f7a922c3731bdb67e11734bfe48ce88c1387babe397cf173803d9',
       i686: '116e6672c979c5437e3b6f09d77115193abfdfea29571eeeea9c99e1203482de',
     x86_64: '1f1d306f729cf04dd1d29979df6caefa5d8e6cfaa2dafd404a807d16b0f08a4b',
  })

  depends_on 'cairo'
  depends_on 'libsigcplusplus'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/cairomm-1.12.2/' \
    -i docs/Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
