require 'package'

class Links < Package
  description 'Links is text WWW browser with tables and frames.'
  homepage 'http://www.jikos.cz/~mikulas/links/'
  version '1.03'
  compatibility 'all'
  source_url 'http://www.jikos.cz/~mikulas/links/download/links-1.03.tar.gz'
  source_sha256 '32443c6f011216a8a43ed0806d9d23c1defdd19bc4b021ee00cda197782e175a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/links-1.03-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/links-1.03-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/links-1.03-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/links-1.03-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de75740c75a6b141e68df3ab31a834890f79834843df543f1de9fbb077665d40',
     armv7l: 'de75740c75a6b141e68df3ab31a834890f79834843df543f1de9fbb077665d40',
       i686: '70a3a6c7fdcc9efd24b99e4526d1bf97d189b0d6180b89b51a455e5a23c60310',
     x86_64: '4975b03ad6b4cda6b09f7e8ad16b90cc30adc01e2da30547c3e29fee130c1072',
  })

  depends_on 'openssl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
