require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2017-03-21'
  source_url 'http://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2017.03.21.tar.xz'
  source_sha256 '386ad455f12bdeb3a7d19280441a5ab77355142349200ff11040a8d9d455d765'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/autoconf_archive-2017-03-21-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/autoconf_archive-2017-03-21-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/autoconf_archive-2017-03-21-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/autoconf_archive-2017-03-21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7bc2a58e881a0c4c9b397b97610285435908bfaeb12f95019f0de9f83c28a8b',
     armv7l: 'b7bc2a58e881a0c4c9b397b97610285435908bfaeb12f95019f0de9f83c28a8b',
       i686: 'dd45fdfbc8245782d42b5c62a2b191e26cec41acde7ecaac333eb5ffe2acba78',
     x86_64: '029ec35f3739e103e18486bc985463809fd91b49e0f8ca236a33cd014f69cebf',
  })

  depends_on 'perl'
  depends_on 'm4'
  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
