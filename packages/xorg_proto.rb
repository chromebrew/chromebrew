require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2019.2'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2019.2.tar.bz2'
  source_sha256 '46ecd0156c561d41e8aa87ce79340910cdf38373b759e737fcbba5df508e7b8e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2019.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2019.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2019.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2019.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd9e18300bfff03320a890f93f3596ef598c072384bc364bde913d5ff707dc6f2',
     armv7l: 'd9e18300bfff03320a890f93f3596ef598c072384bc364bde913d5ff707dc6f2',
       i686: '265aed098ec9396c8f8944412c1cf1c83d8268fe4c5a663567cb845ff64eb7be',
     x86_64: '14fec9e0ec5ad52bbf1035a080f2c16be9533e2090b78f3d06336990ebd2b99f',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--datadir=#{CREW_LIB_PREFIX}",   # install *.pc in #{CREW_LIB_PREFIX}/pkgconfig
           '--enable-strict-compilation',
           '--enable-specs'
    system 'make'
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
