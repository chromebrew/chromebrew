require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.4.3'
  compatibility 'all'
  source_url 'https://www.libarchive.org/downloads/libarchive-3.4.3.tar.xz'
  source_sha256 '0bfc3fd40491768a88af8d9b86bf04a9e95b6d41a94f9292dbc0ec342288c05f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd655aeae8c2c016a7f519bac200b8f8c646f438de69867c2e50e2cd25282423b',
     armv7l: 'd655aeae8c2c016a7f519bac200b8f8c646f438de69867c2e50e2cd25282423b',
       i686: 'ca338f3a39b21c2d29ad361b0f97ade39d2396fa3c911be3edf7525b0948cd65',
     x86_64: 'adad9cf581d9dc117e24f799fb9cbaa845c9eb60b688a947bd83d22747cc56fa',
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
