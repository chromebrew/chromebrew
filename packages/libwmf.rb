require 'package'

class Libwmf < Package
  description 'libwmf is a library for reading vector images in Microsoft\'s native Windows Metafile Format (WMF)'
  homepage 'http://wvware.sourceforge.net/libwmf.html'
  version '0.2.8.4'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/wvware/libwmf/0.2.8.4/libwmf-0.2.8.4.tar.gz'
  source_sha256 '5b345c69220545d003ad52bfd035d5d6f4f075e65204114a9e875e84895a7cf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.8.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c725015783a8ade0fe8aa5dcffea09b175f60c07a2caada81f12b7c44101eaca',
     armv7l: 'c725015783a8ade0fe8aa5dcffea09b175f60c07a2caada81f12b7c44101eaca',
       i686: '804a2bce1a2622b55d8311978348f93e44fe1f652a301fd589eb581a464fbb5c',
     x86_64: '2b215b744ad624b72b2974e8094a68af62fbd99c657df8c7d9c7e472fa03f156',
  })

  depends_on 'gtk2'
  depends_on 'libgd'
  depends_on 'libjpeg'
  depends_on 'xorg_server'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
