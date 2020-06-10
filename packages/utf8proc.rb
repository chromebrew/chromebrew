require 'package'

class Utf8proc < Package
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.1.0-1'
  compatibility 'all'
  source_url 'https://github.com/JuliaLang/utf8proc/archive/v2.1.0.tar.gz'
  source_sha256 '25ccc5619ac400f9eaf24aafaae5b625afa1961e140b8dd6072b393267833260'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c64f1656e7dc1b7c3395661dacfb0f9d4b043e94ff07e0baf0ee8cc04fd8f757',
     armv7l: 'c64f1656e7dc1b7c3395661dacfb0f9d4b043e94ff07e0baf0ee8cc04fd8f757',
       i686: '9bbc7e68deb6dbc1888fd1ac8300485114a288264baca54babc0adcb0cee5eba',
     x86_64: '837e33dad2cc4db985980978e4ffdebe7316e1f6aacf5308d00e78e65c00e627',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
