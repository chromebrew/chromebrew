require 'package'

class Fontforge < Package
  description 'Free (libre) font editor for Windows, Mac OS X and GNU+Linux'
  homepage 'http://fontforge.github.io/'
  version '20170731'
  compatibility 'all'
  source_url 'https://github.com/fontforge/fontforge/releases/download/20170731/fontforge-dist-20170731.tar.xz'
  source_sha256 '840adefbedd1717e6b70b33ad1e7f2b116678fa6a3d52d45316793b9fd808822'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontforge-20170731-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontforge-20170731-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontforge-20170731-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontforge-20170731-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e351e85b7b21d8fe58c2f5eed81cf6d8eadb0cbf478797e83e1a71381ce68de',
     armv7l: '0e351e85b7b21d8fe58c2f5eed81cf6d8eadb0cbf478797e83e1a71381ce68de',
       i686: '4db11a38e864354427fab3e2c9a2fde8cf96b6eba6f4bc3c5f979e90b65a2427',
     x86_64: 'c7bd918c9064f5ade5f0c5040d11a67ff3addb42f5073b76afbeb51ba32b73cc',
  })

  depends_on 'gtk2'
  depends_on 'pango'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-gtk2-use',
           '--with-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
