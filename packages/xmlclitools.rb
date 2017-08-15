require 'package'

class Xmlclitools < Package
  description 'xmlclitools provides four command-line tools for searching, modifying, and formating XML data. The tools are designed to work in conjunction with standard *nix utilities such as grep, sort, and shell scripts.'
  homepage 'http://freecode.com/projects/xmlclitools'
  version '1.61'
  source_url 'ftp://ftp.nstu.ru/pub/sources/langs/xml/xmlclitools-1.61.tar.gz'
  source_sha256 '262ce2f119a278ee2f965722f4d23b6b67f8baaa594858b9a0124849726e5a63'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/xmlclitools-1.61-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/xmlclitools-1.61-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/xmlclitools-1.61-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/xmlclitools-1.61-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd267a0a8df6fc778757b489191f93576166b4bf29b131fb3528602733a9f8730',
     armv7l: 'd267a0a8df6fc778757b489191f93576166b4bf29b131fb3528602733a9f8730',
       i686: 'f0d5eeb54dc33f7e25682cbce3fb70ca1e2db931fd6f1de53bc29d92ebd52c15',
     x86_64: '7e654d9de988f26abd353dcc36777ebe6e2f6323c03192e1560e8f98b6515321',
  })

  depends_on 'glib'
  depends_on 'pcre'
  depends_on 'libxml2'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
