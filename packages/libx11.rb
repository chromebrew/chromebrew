require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.5-0'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.5.tar.gz'
  source_sha256 '3abce972ba62620611fab5b404dafb852da3da54e7c287831c30863011d28fb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'fb45a99ab1b5f04df4bcca139ce7f2f82118a4ae3aeb4c45e22b7aff88a44fea',
     armv7l: 'fb45a99ab1b5f04df4bcca139ce7f2f82118a4ae3aeb4c45e22b7aff88a44fea',
       i686: '6305ea62f76ebe2ab3a1e70182929309a08ef19681f1edf07fe9383d3efb073e',
     x86_64: '8728fdd9b7282e4aae047ade6efe162ac6a3f6c851c5c23bae5f93fcd17d40ec',

  })

  depends_on 'kbproto'
  depends_on 'libxcb'
  depends_on 'xproto'
  depends_on 'inputproto'
  depends_on 'xextproto'
  depends_on 'libxtrans'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
