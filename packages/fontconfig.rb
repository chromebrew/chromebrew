require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.13.92'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.92.tar.xz'
  source_sha256 '506e61283878c1726550bc94f2af26168f1e9f2106eac77eaaf0b2cdfad66e4e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.92-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.92-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.92-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.92-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2901e70451140802f63b96ebf5e74d5e13ac7f1c4f54962329854bb195bface1',
     armv7l: '2901e70451140802f63b96ebf5e74d5e13ac7f1c4f54962329854bb195bface1',
       i686: '38af5a4671f0f347af336dbcbe48f98966207c5a25935ff0ce5de487a7edc627',
     x86_64: '344e1ee8d34f9f7ad84cf4d1e92a28f71e2fbcd599f97a8abfc085fb2fbe9120',
  })

  depends_on 'expat'
  depends_on 'gperf'
  depends_on 'freetype_sub'
  depends_on 'jsonc'
  depends_on 'util_linux'

  def self.build
    system "./configure #{CREW_OPTIONS} --localstatedir=#{CREW_PREFIX}/cache"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
