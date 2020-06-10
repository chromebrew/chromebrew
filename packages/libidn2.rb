require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.0.5'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libidn/libidn2-2.0.5.tar.gz'
  source_sha256 '53f69170886f1fa6fa5b332439c7a77a7d22626a82ef17e2c1224858bb4ca2b8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '533ce10819b7a6e59302480c895d7da9f498a187218296c2debee09a85b7f87d',
     armv7l: '533ce10819b7a6e59302480c895d7da9f498a187218296c2debee09a85b7f87d',
       i686: 'd07969ea21a9f390afe961dcbb78f014c17cfd5bc3af6dbb4732e32004f61e6a',
     x86_64: '22b43990ca6ae415b9b7e206ed7d7b05df29b97411de55f33f11e834cf3b345c',
  })

  depends_on 'libiconv'

  def self.build
    system 'autoreconf -i -f'
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
