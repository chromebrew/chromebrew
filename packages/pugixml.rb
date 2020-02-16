require 'package'

class Pugixml < Package
  description 'Light-weight, simple and fast XML parser for C++ with XPath support'
  homepage 'https://pugixml.org/'
  version '1.10'
  source_url 'https://github.com/zeux/pugixml/releases/download/v1.10/pugixml-1.10.tar.gz'
  source_sha256 '55f399fbb470942410d348584dc953bcaec926415d3462f471ef350f29b5870a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pugixml-1.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pugixml-1.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pugixml-1.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pugixml-1.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c948a90abf61186a25c71ed9434e9bea9ac7f6a88578c05fe40ba006ede7d561',
     armv7l: 'c948a90abf61186a25c71ed9434e9bea9ac7f6a88578c05fe40ba006ede7d561',
       i686: '98434a99ee0c01a9b571939e206d2a0c62205abacd3cbc06a9226147837762ef',
     x86_64: 'a3c3a28cad9b0e278c5d3e863d73b5ad4ec9498bb5d2f21804946d786af18234',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DBUILD_SHARED_LIBS=ON',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
