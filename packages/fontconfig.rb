require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.13.0'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.0.tar.gz'
  source_sha256 'a6ca290637d8b2c4e1dd40549b179202977593f7481ec83ddfb1765ad90037ba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ced3440f18ee896c1623ecd1ef3c493c41f6947ee4c6b4c54cd6bd23080e42ff',
     armv7l: 'ced3440f18ee896c1623ecd1ef3c493c41f6947ee4c6b4c54cd6bd23080e42ff',
       i686: '64a8085ac2a3cb30c1d523133778a868ece074fa973c5f7b0548b9b639f7ecb2',
     x86_64: '7df51056ad09bf3b74fc1e85e6049306322f55641b191f3a8fa0378281c71702',
  })

  depends_on 'expat'
  depends_on 'gperf'
  depends_on 'freetype'
  depends_on 'util_linux'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/cache"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
