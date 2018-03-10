require 'package'

class Font_util < Package
  description 'X.Org font utilities'
  homepage 'https://www.freedesktop.org'
  version '1.3.1'
  source_url 'https://www.x.org/archive/individual/font/font-util-1.3.1.tar.bz2'
  source_sha256 'aa7ebdb0715106dd255082f2310dbaa2cd7e225957c2a77d719720c7cc92b921'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f4451fb18696cf52f4ae32c883b48c4f3d01498d86cf8de2bd23ad413955e8c4',
     armv7l: 'f4451fb18696cf52f4ae32c883b48c4f3d01498d86cf8de2bd23ad413955e8c4',
       i686: '8938497e0efbd1ea684742433177fd0d76d818e31b583d1c903a0b45935c5bcf',
     x86_64: '8bac57c788ba219f59274697ce0b056d61232ec78db7ed7e110cf7917896d1e6',
  })

    depends_on 'util_macros'

    
  def self.build
      system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
