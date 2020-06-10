require 'package'

class Libexif < Package
  description 'A library for parsing, editing, and saving EXIF data'
  homepage 'https://libexif.github.io/'
  version '0.6.21'
  compatibility 'all'
  source_url 'https://github.com/libexif/libexif/archive/libexif-0_6_21-release.tar.gz'
  source_sha256 '8cb37aa1745ca9050403c501ad4da2924e98ec5460bbd5c9d09bd57f0c746636'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c4d28a7a1a806559be725e264daf15759921281cd53d584fc66a2de955c4b48a',
     armv7l: 'c4d28a7a1a806559be725e264daf15759921281cd53d584fc66a2de955c4b48a',
       i686: '7b03b0d97715f99eebdeac70afe4d3562309eda01523d648a6680b02107eb5cf',
     x86_64: 'ffe068550dd1f366252762ee529a8bd10984f1036d11984bfefabb468893da21',
  })

  def self.build
    system 'autoreconf -i -f'
    system "sed -i '69,70d' po/Makefile.in.in"
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
