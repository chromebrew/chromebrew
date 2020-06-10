require 'package'

class Whiptail < Package
  description 'displays dialog boxes from shell scripts.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/cvs/general/newt.html'
  version '0.52.20'
  compatibility 'all'
  source_url 'https://releases.pagure.org/newt/newt-0.52.20.tar.gz'
  source_sha256 '8d66ba6beffc3f786d4ccfee9d2b43d93484680ef8db9397a4fb70b5adbb6dbc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/whiptail-0.52.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/whiptail-0.52.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/whiptail-0.52.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/whiptail-0.52.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb960ee1d2777418158f511ec5a0f5914ed496506c541836c41cdd9429cd0176',
     armv7l: 'bb960ee1d2777418158f511ec5a0f5914ed496506c541836c41cdd9429cd0176',
       i686: '164c1efd679bfa0c5921cb7a8fe0ad39100d277d8a937af8370dc7517ea98d4d',
     x86_64: '37464683ae2aec9af4788ab3159ea8de3b407092cc1bb06bdc94937291ec5a93',
  })

  depends_on 'popt'
  depends_on 'slang'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
