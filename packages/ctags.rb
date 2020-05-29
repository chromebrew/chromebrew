require 'package'

class Ctags < Package
  description 'Exuberant Ctags is a multilanguage reimplementation of the Unix ctags utility.'
  homepage 'https://sourceforge.net/projects/ctags/'
  version '5.8-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/ctags/ctags/5.8/ctags-5.8.tar.gz'
  source_sha256 '0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f45accfda62bd74f626024d1a44b9ce3df6a79342f4ef1137cc9abaea3031fc',
     armv7l: '7f45accfda62bd74f626024d1a44b9ce3df6a79342f4ef1137cc9abaea3031fc',
       i686: '0c691ea7dd4608d4fc3b8b26c53eebefa6c3049b76e3d74fd1df3bc34c0460f9',
     x86_64: 'ec5a895588b0b6f56928a44c089b3a52b2eedc8092c1b22994e72fa62442a7ab',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "install -Dm755 ctags #{CREW_DEST_PREFIX}/bin/ctags"
    system "install -Dm644 ctags.1 #{CREW_DEST_MAN_PREFIX}/man1/ctags.1"
  end
end
