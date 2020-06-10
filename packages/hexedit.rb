require 'package'

class Hexedit < Package
  version '1.2.13'
  description 'Hex Editor for Linux.'
  homepage 'http://rigaux.org/hexedit.html'
  compatibility 'all'
  source_url 'http://rigaux.org/hexedit-1.2.13.src.tgz'
  source_sha256 '6a126da30a77f5c0b08038aa7a881d910e3b65d13767fb54c58c983963b88dd7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hexedit-1.2.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hexedit-1.2.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hexedit-1.2.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hexedit-1.2.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f241f818b97690420d56e6efac8126e637ccaaac6adbea877ba31a846f56f4c0',
     armv7l: 'f241f818b97690420d56e6efac8126e637ccaaac6adbea877ba31a846f56f4c0',
       i686: 'cc48b59ad9eb13df2404eccfefa7bbb002eaa2c232212d159188ae12354e2b4a',
     x86_64: 'ff405baf2783242b6af5d3e7a86268ebbe51ab3cf1a3dedd33e1fe1e46dcd74b',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make", "CFLAGS=-I#{CREW_PREFIX}/include/ncurses"
  end

  def self.install
    system "make", "prefix=#{CREW_DEST_PREFIX}", "install"
  end
end
