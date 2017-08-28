require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.29-1'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.29.tar.gz'
  source_sha256 'b5976e3857837e7617b29f2249ebb5eeac34e249208d31f1fbf7a6ba7a4090ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.29-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.29-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.29-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxslt-1.1.29-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '93810e7cb10c1a121bac5c86265631983381eeea027b4b0192a5b2fc5ee0192d',
     armv7l: '93810e7cb10c1a121bac5c86265631983381eeea027b4b0192a5b2fc5ee0192d',
       i686: '2f8547b35ca4907e7566ae9724d59fde47b93c88e511a6171fd285412dc1bb47',
     x86_64: 'a8c584e1b00639cdaa70a73f103b42c9870918364733624a738d9b9a9c6d1822',
  })

  depends_on 'libxml2'

  def self.build
    system "./configure", "--without-python", "--disable-static", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
