require 'package'

class Libslz < Package
  description 'SLZ is a fast and memory-less stream compressor which produces an output that can be decompressed with zlib or gzip.'
  homepage 'http://www.libslz.org/'
  version '1.1.0-2'
  compatibility 'all'
  source_url 'http://git.1wt.eu/web?p=libslz.git;a=snapshot;h=f65544ca6a0d628b1db2d76069cc3be493543d38;sf=tbz2'
  source_sha256 '985cb527a4d1c7a93e9eb19d79f97513eb57cfe6e112b727976855c8144ffccc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libslz-1.1.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libslz-1.1.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libslz-1.1.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libslz-1.1.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '506026ec40d5166c94d9f95b5b875a0410c53d7eb0cb49cc1ab5464474a05801',
     armv7l: '506026ec40d5166c94d9f95b5b875a0410c53d7eb0cb49cc1ab5464474a05801',
       i686: 'd6aa18b3021cf73a6ed388531df2b7fc6b071ed1eca8cb9f032ff09db7a3bdb8',
     x86_64: 'a50e1317acc35135592b790a6daefae66c3b04eb2d07b5be2a97e07dec7a0328',
  })

  def self.build
    system "sed -i 's,LIBDIR     := \$(PREFIX)/lib,LIBDIR     := #{CREW_LIB_PREFIX},' Makefile"
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
