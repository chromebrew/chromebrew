require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.10.2-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.2/libxml2-v2.10.2.tar.bz2'
  source_sha256 'd50e8a55b2797501929d3411b81d5d37ec44e9a4aa58eae9052572977c632d7a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.2-1_armv7l/libxml2-2.10.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.2-1_armv7l/libxml2-2.10.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.2-1_i686/libxml2-2.10.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.2-1_x86_64/libxml2-2.10.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '69c9c14c155c554bb8a093f65537233c6844fc2e8bb4c4700942091a3e1bb8db',
     armv7l: '69c9c14c155c554bb8a093f65537233c6844fc2e8bb4c4700942091a3e1bb8db',
       i686: 'f416b5a9c84e55e249cfb8249bb5b67f67d5d2b32ce28a8b80678f22a1516fac',
     x86_64: '14cc527ce6f0f9622974069459a1d931910de6df810fecb91e806d813a34ad93'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses'
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R
  no_patchelf

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
