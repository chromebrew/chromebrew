require 'package'

class Utf8proc < Package
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.1.0'
  source_url 'https://github.com/JuliaLang/utf8proc/archive/v2.1.0.tar.gz'
  source_sha256 '25ccc5619ac400f9eaf24aafaae5b625afa1961e140b8dd6072b393267833260'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8213bc0c9ce9ba36ddbb31fbaeba179e52a8981051dc61e73955c7c7975383d',
     armv7l: 'd8213bc0c9ce9ba36ddbb31fbaeba179e52a8981051dc61e73955c7c7975383d',
       i686: 'ff35d06eb1518943071c7338793d99f024a778eb3f80a64183efa2ef9d13f087',
     x86_64: 'e0ca67c98ccb10c8e27a9e00a53d693d4a4ba23c1935d22cb4c56826460c8da3',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
