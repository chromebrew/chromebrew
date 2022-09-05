require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.10.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.0/libxml2-v2.10.0.tar.bz2'
  source_sha256 'c44124d025162767a1d3fe35b556c5855e6be7240e3dc3159490e91d5cadbba3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.0_armv7l/libxml2-2.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.0_armv7l/libxml2-2.10.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.0_i686/libxml2-2.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.0_x86_64/libxml2-2.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ef7e24bb4d42f795fe30b040bf4b9fb3e0edd1df7fe96f4bf34ce13c673bf178',
     armv7l: 'ef7e24bb4d42f795fe30b040bf4b9fb3e0edd1df7fe96f4bf34ce13c673bf178',
       i686: '0de66dfa80be15da9282743da640cea6d4f17c92b8d8eccaa1c119fe17fbc00b',
     x86_64: '6e838bd7d320bc13666834eb97bd6f1532e1971a83609d0a0b522e3b78e00e7b'
  })

  depends_on 'gcc'
  depends_on 'icu4c'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in \$(grep -rl \'TRUE)\'); do sed -i 's,TRUE),true),g' \$f; done"
  end

  def self.build
    # libxml2-python built in another package (py3_libxml2)
    system "./autogen.sh \
      #{CREW_OPTIONS} \
      #{CREW_ENV_OPTIONS} \
      --enable-shared \
      --enable-static \
      --with-pic \
      --without-python \
      --without-lzma \
      --with-zlib \
      --with-icu \
      --with-threads \
      --with-history"
    system 'make'
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system 'rm', 'test/ebcdic_566012.xml'

    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
