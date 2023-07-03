require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.11.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.11.4/libxml2-v2.11.4.tar.bz2'
  source_sha256 'a9493ae091f58037dd5e73fc6035a4907eae58e2cc4756abc4e6253ee6036166'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.4_armv7l/libxml2-2.11.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.4_armv7l/libxml2-2.11.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.4_i686/libxml2-2.11.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.4_x86_64/libxml2-2.11.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '025d895d0c2cb499ad612da71f0ab928a6d010c5b85060bed5e145bb2e077d1e',
     armv7l: '025d895d0c2cb499ad612da71f0ab928a6d010c5b85060bed5e145bb2e077d1e',
       i686: '3836e2106e03f410c02b08e66095d9b943ad2d0a119d56585bdf0297963f1273',
     x86_64: '310ce944062d26f07773cce0a891195e9918ab806b9f951b273004a09188b0ed'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in $(grep -rl 'TRUE)'); do sed -i 's,TRUE),true),g' $f; done"
  end

  def self.build
    # libxml2-python built in another package (py3_libxml2)
    system "./autogen.sh \
      #{CREW_OPTIONS} \
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
