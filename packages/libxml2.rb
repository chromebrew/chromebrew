require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.11.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.11.5/libxml2-v2.11.5.tar.bz2'
  source_sha256 'ab3699b697e917c7d5035e81d237a9bc895eb4bf70c0a2259c6d1f125c1b77b6'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.5_armv7l/libxml2-2.11.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.5_armv7l/libxml2-2.11.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.5_i686/libxml2-2.11.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.5_x86_64/libxml2-2.11.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4de8edf0e7e220cd5e174ea95ba8c4cad62182764b07a26ce2f2c522008bb0ac',
     armv7l: '4de8edf0e7e220cd5e174ea95ba8c4cad62182764b07a26ce2f2c522008bb0ac',
       i686: '07c89f113d9f5df241575805f2cd2df8d4a5778db5279ee52123fe760d8c4f78',
     x86_64: '28e483b82cc026a53b5767ede5b2a2567ac1b76b2a73e02ee5bbc2c8dcfd012a'
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
