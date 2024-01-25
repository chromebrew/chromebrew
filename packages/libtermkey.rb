# Adapted from Arch Linux libtermkey PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libtermkey/trunk/PKGBUILD

require 'package'

class Libtermkey < Package
  description 'Library for easy processing of keyboard entry from terminal-based programs'
  homepage 'http://www.leonerd.org.uk/code/libtermkey'
  version '0.22'
  license 'MIT'
  compatibility 'all'
  source_url 'http://www.leonerd.org.uk/code/libtermkey/libtermkey-0.22.tar.gz'
  source_sha256 '6945bd3c4aaa83da83d80a045c5563da4edd7d0374c62c0d35aec09eb3014600'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6b1aa10ee1938f39b622256fe7afc6676efd607910df87ac19270caf88919a7',
     armv7l: 'a6b1aa10ee1938f39b622256fe7afc6676efd607910df87ac19270caf88919a7',
       i686: '81e147cc8748cf399b9db7fd5aafffd1e1d3040222157773d6d78c753329e551',
     x86_64: '60bc1246305e3d00fbf172b1d062aefcc5bc40ea54859d360fa0faee587c6cd4'
  })

  depends_on 'unibilium'

  def self.build
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
