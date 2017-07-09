require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.4'
  source_url 'https://www.x.org/archive/individual/lib/libXdamage-1.1.4.tar.gz'
  source_sha256 '4bb3e9d917f5f593df2277d452926ee6ad96de7b7cd1017cbcf4579fe5d3442b'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxdamage-1.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxdamage-1.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libxdamage-1.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libxdamage-1.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c9abe9268a3ac340598e1b15665ac2bdf2b63eefce22028a0ccd51f23791f994',
     armv7l: 'c9abe9268a3ac340598e1b15665ac2bdf2b63eefce22028a0ccd51f23791f994',
       i686: 'e3a1ff3de3d2fdf105d12e13e9c053fd1c1a80433d96a521f3a23fdcc09bde13',
     x86_64: '30d9a122648f4fbe8754ecdb67b00a6ca21e7e829f03b9652209f517e575c82e',
  })

  depends_on 'fixesproto'
  depends_on 'libxfixes'
  depends_on 'xextproto'
  depends_on 'libx11'
  depends_on 'damageproto'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
