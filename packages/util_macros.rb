require 'package'

class Util_macros < Package
  description 'The util-macros package contains the m4 macros used by all of the Xorg packages'
  homepage 'https://www.linuxfromscratch.org/blfs/view/svn/util-macros.html'
  version '1.19.1'
  source_url 'https://www.x.org/pub/individual/util/util-macros-1.19.1.tar.bz2'
  source_sha256 '18d459400558f4ea99527bc9786c033965a3db45bf4c6a32eefdc07aa9e306a6'


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    #system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
