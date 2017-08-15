require 'package'

class Libxtrans < Package
  description 'transpot library for the X window system'
  homepage 'https://x.org'
  version '1.3.5'
  source_url 'https://www.x.org/archive/individual/lib/xtrans-1.3.5.tar.gz'
  source_sha256 'b7a577c1b6c75030145e53b4793db9c88f9359ac49e7d771d4385d21b3e5945d'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxtrans-1.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxtrans-1.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libxtrans-1.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libxtrans-1.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f24adbe167591862224c01bc4028859b75ece584294b70c596b3abc661412c36',
     armv7l: 'f24adbe167591862224c01bc4028859b75ece584294b70c596b3abc661412c36',
       i686: '4be3d8dcb02e6ec49c029d57c01acc975455fe48f97051199324d86fa4e4e084',
     x86_64: '1e68d2c11408aa15d71f2c6dde4023a72d51a922ce8f3eadac4a6d48cbbd3fe2',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
