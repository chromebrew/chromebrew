require 'package'

class Libass < Package
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.13.6-1'
  source_url 'https://github.com/libass/libass/archive/0.13.6.tar.gz'
  source_sha256 'de68288397d284a955061b3ecba67152cea74d8ace6222d987dd30091b1534b7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.13.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.13.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.13.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.13.6-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0b0996d9626e827c7a22b95c7eb59217b657afa2044934884167deaae217d106',
     armv7l: '0b0996d9626e827c7a22b95c7eb59217b657afa2044934884167deaae217d106',
       i686: 'd9ed5ea138dda3cff16e20b33534cf3cd7f3cead250cd7c5b74347bf517938fa',
     x86_64: 'dbc621f3d5fb1d39338fbd2b7e7f1237b12d67f8e46f95a999550680ab0ecbfd',
  })

  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'fontconfig'
  depends_on 'libtool' => :build

  def self.build
    system "./autogen.sh"
    system "autoconf"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
