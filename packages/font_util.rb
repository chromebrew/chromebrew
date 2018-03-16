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
    aarch64: 'e0bbbcdc483e4aa4c1c1df6415ad17ee870b95fbe54e01183e1562822cf9a46f',
     armv7l: 'e0bbbcdc483e4aa4c1c1df6415ad17ee870b95fbe54e01183e1562822cf9a46f',
       i686: 'acff7fde30def5205ff0c2809fbff5d3914be2ea7473bfe9db81aa2edf259b85',
     x86_64: '0e3e3dd3f83cbf53f3d80113d367cb7e69fbcbe6e68653687c7498d3e3260c7b',
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
