require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'http://freecode.com/projects/lhaforunix'
  version '1.14i-ac20050924p1'
  source_url 'http://prdownloads.sourceforge.jp/lha/22231/lha-1.14i-ac20050924p1.tar.gz'
  source_sha256 'b5261e9f98538816aa9e64791f23cb83f1632ecda61f02e54b6749e9ca5e9ee4'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lha-1.14i-ac20050924p1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lha-1.14i-ac20050924p1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/lha-1.14i-ac20050924p1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/lha-1.14i-ac20050924p1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '91d78303d21513770339e9a6ca3ec64cb285038b8f9957beee7ef33bd9ff1ee4',
     armv7l: '91d78303d21513770339e9a6ca3ec64cb285038b8f9957beee7ef33bd9ff1ee4',
       i686: '4a841f670a5555e50e352f1d189709c7c221492dc851091650c6da3d3efa63a2',
     x86_64: '9280e8721afc828eaaa7b9d8b26550ccef1356e51b841363e83425b1588092ff',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
