require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.5'
  source_url 'https://downloads.sourceforge.net/project/expat/expat/2.2.5/expat-2.2.5.tar.bz2'
  source_sha256 'd9dc32efba7e74f788fcc4f212a43216fc37cf5f23f4c2339664d473353aedf6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd4fa088b346329e2cf8fd1d11bc56fd5c6a8eac4053d39656cc5345d7734471b',
     armv7l: 'd4fa088b346329e2cf8fd1d11bc56fd5c6a8eac4053d39656cc5345d7734471b',
       i686: '8af1d7c0f458360eed69132acaaf22008db74f2f602b8aafd75203f168bf76d6',
     x86_64: '164b4f7de9bc956d13514b7fe66f9e7c3745fc6988b25e53e754325d40070fab',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
