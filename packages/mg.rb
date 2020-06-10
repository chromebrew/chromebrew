require 'package'

class Mg < Package
  description 'mg is the portable version of the mg editor from OpenBSD'
  homepage 'https://devio.us/~bcallah/mg/'
  version '20170917'
  compatibility 'all'
  source_url 'https://devio.us/~bcallah/mg/mg-20170917.tar.gz'
  source_sha256 'def9237a89ec6a14241abaf12714bc5fcb3b0e2f8d9d466ff7561628d35b7ff1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mg-20170917-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mg-20170917-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mg-20170917-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mg-20170917-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9c9ee8e796407f78ce16b6f6da3c1faf2d04f1a6691bc2f020cf27258cfd585f',
     armv7l: '9c9ee8e796407f78ce16b6f6da3c1faf2d04f1a6691bc2f020cf27258cfd585f',
       i686: '9655b3efbe43f45e6ec46eb9f0ff36727f155e2dce90c5d3b03266b3df1c825c',
     x86_64: 'b33010e42645f5b311ca7b1ca3dcbab53ad033aab3cedab2ec6a3e73f7a1dafa',
  })

  depends_on 'ncurses'

  def self.build
    system "CFLAGS=-I#{CREW_PREFIX}/include/ncurses make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
