require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.10.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.3/libxml2-v2.10.3.tar.bz2'
  source_sha256 '302bbb86400b8505bebfbf7b3d1986e9aa05073198979f258eed4be481ff5f83'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.3_armv7l/libxml2-2.10.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.3_armv7l/libxml2-2.10.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.3_i686/libxml2-2.10.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.3_x86_64/libxml2-2.10.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dd632f61bf378aa089500a377e1192650e7ee22d373f09ee3be981a54db764be',
     armv7l: 'dd632f61bf378aa089500a377e1192650e7ee22d373f09ee3be981a54db764be',
       i686: '5a49faa80100a3a7d893ead1a324773c671550cb6647cab48660acec35dbfcde',
     x86_64: 'a54015b9df27a83262c999d2e00946c928206900a4303ee0f6b3e44b46597d56'
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
    system "for f in $(grep -rl 'TRUE)'); do sed -i 's,TRUE),true),g' $f; done"
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
