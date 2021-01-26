require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  @_ver = '5.10.0'
  version @_ver
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/snapshot/xfsprogs-dev-#{@_ver}.tar.gz"
  source_sha256 'e807ca9fd8f01e45c9ec8ffb3c123bdb7dfcfd8e05340520d2ff1ddbc3bd7c88'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xfsprogs-5.10.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xfsprogs-5.10.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/xfsprogs-5.10.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xfsprogs-5.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'd2034b7ee2c95673d900aed424c04abe6f53cc721261ef3b5822c4d98ca720ef',
      armv7l: 'd2034b7ee2c95673d900aed424c04abe6f53cc721261ef3b5822c4d98ca720ef',
        i686: '98a742b31c4082d649150f22a9d58342f41f46d1f97d03e38d835bb1b3517583',
      x86_64: 'bf575a97e5fbd3cfce4a0f7e547ccb4bcf99b9e05067b112813c8967c904f42e',
  })

  depends_on 'libinih'

  def self.build
    system "make configure"
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      DEBUG=-DNDEBUG ./configure #{CREW_OPTIONS} --sbindir=#{CREW_PREFIX}/bin"
    system "make"
  end
  
  def self.install
    system "make DIST_ROOT=#{CREW_DEST_DIR} PKG_ROOT_SBIN_DIR=#{CREW_PREFIX}/bin install install-dev"
  end
end
