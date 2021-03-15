require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '5.10'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-5.10.tar.xz'
  source_sha256 '75102535ba119f2f223f674d84e1dcdaebf0a5ffd639b3c2e6cb0a0e34768762'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-5.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-5.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-5.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-5.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f744832c6e15601fa603a42bb12f8b1d9500ddd1f1e39444970e57a5c2d2e2db',
     armv7l: 'f744832c6e15601fa603a42bb12f8b1d9500ddd1f1e39444970e57a5c2d2e2db',
       i686: '0a4ae4dc6cd4896e5f3ab4708eb7a6463ddd0ed2f59840e19035dbf8d17ae4c9',
     x86_64: '3b8dac6ed2af12ac5a8ebee632d548fc26b8526ad7795533e16a4291c7227c03',
  })

  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "install"
  end

  def self.postinstall
    puts "Try 'man printf' to see if it works.".lightblue
  end
end
