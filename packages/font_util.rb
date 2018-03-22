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
    aarch64: '37a5171ab42bf759a2d7f878b541de7f68a3701fb8144561c0f6f29473b2cce2',
     armv7l: '37a5171ab42bf759a2d7f878b541de7f68a3701fb8144561c0f6f29473b2cce2',
       i686: 'ad05ed87b4da0069c731bcd3a17f077b9d317c3784c2a954c4284bc1197e5434',
     x86_64: '3d87ede9af652619cfc28f1cf16779a841228233978605c9a234501b789fd86c',
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
