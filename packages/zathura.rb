require 'package'

class Zathura < Package
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '0.4.5'
  compatibility 'all'
  source_url 'https://pwmt.org/projects/zathura/download/zathura-0.4.5.tar.xz'
  source_sha256 '0c3997aafbcdaaae60a4522f208adadfdd2758b432ce94ea16fbcee937cb762c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec4a508b374e3169f04fe2018ae95d3fe9b7a88a2604bfcfe1a7a1ecd1f0aa6e',
     armv7l: 'ec4a508b374e3169f04fe2018ae95d3fe9b7a88a2604bfcfe1a7a1ecd1f0aa6e',
       i686: 'a1e6e108ff1747f6297faa3497bca3d4ad88fb4969955f5aacbfba5116168eed',
     x86_64: '05b3d7cd6b2ee0548041bb6a8a3743560962ad84350f547642a3a30b1fa89dda',
  })

  depends_on 'girara'
  depends_on 'zathura_poppler_pdf'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
