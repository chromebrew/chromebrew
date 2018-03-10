require 'package'

class Font_util < Package
  description 'X.Org font utilities'
  homepage 'https://www.freedesktop.org'
  version '1.3.1'
  source_url 'https://www.x.org/archive/individual/font/font-util-1.3.1.tar.bz2'
  source_sha256 'aa7ebdb0715106dd255082f2310dbaa2cd7e225957c2a77d719720c7cc92b921'

    depends_on 'util_macros'

    
  def self.build
      system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
