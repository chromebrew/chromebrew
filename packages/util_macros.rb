require 'package'

class Util_macros < Package
  description 'The util-macros package contains the m4 macros used by all of the Xorg packages'
  homepage 'https://www.linuxfromscratch.org/blfs/view/svn/util-macros.html'
  version '1.19.1'
  source_url 'https://www.x.org/pub/individual/util/util-macros-1.19.1.tar.bz2'
  source_sha256 '18d459400558f4ea99527bc9786c033965a3db45bf4c6a32eefdc07aa9e306a6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '67c02d4555bfb404d4354e96c6bad90d24c49862fe4e0803ac238044b214e513',
     armv7l: '67c02d4555bfb404d4354e96c6bad90d24c49862fe4e0803ac238044b214e513',
       i686: 'd13eb3e243d1e36df9eda70d69136fd4580abbe185576719f1d8a1ad7bad9a27',
     x86_64: 'fe574b8114f90bc883a75f73a8b9c88c36c8afa12953396d1f196628903f5929',
  })


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
