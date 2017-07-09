require 'package'

class Aprutil < Package
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'http://apr.apache.org/'
  version '1.6.0'
  source_url 'http://apache.claz.org/apr/apr-util-1.6.0.tar.bz2'
  source_sha256 '8474c93fa74b56ac6ca87449abe3e155723d5f534727f3f33283f6631a48ca4c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/aprutil-1.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/aprutil-1.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/aprutil-1.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/aprutil-1.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0c43c0acf059f91ed31c429facf69cc3c381093fd48f06ff377897199bdae49e',
     armv7l: '0c43c0acf059f91ed31c429facf69cc3c381093fd48f06ff377897199bdae49e',
       i686: 'da915a6f7c4e5827f177b0f5473295d3a8886704e383e11a167961690d7a532b',
     x86_64: '3054b966fa64e6b793210563fe01195238cbbacc4d31c33830cc2bfc39925836',
  })

  depends_on 'apr'
  depends_on 'expat'

  def self.build
    system './configure --prefix=/usr/local --with-apr=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
