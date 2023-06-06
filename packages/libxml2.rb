require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.11.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.11.3/libxml2-v2.11.3.tar.bz2'
  source_sha256 '44b38be302a103c62f80e792478a505365693349a76ea6b98e9c68aab8eab9e0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.3_armv7l/libxml2-2.11.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.3_armv7l/libxml2-2.11.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.3_i686/libxml2-2.11.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.11.3_x86_64/libxml2-2.11.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f9385326fbe519211d28026c79e9e0a01ab9909f0f0177e769c7684548154bab',
     armv7l: 'f9385326fbe519211d28026c79e9e0a01ab9909f0f0177e769c7684548154bab',
       i686: 'fabaabc7d32e9648b77f470c40bbf94a25a32df100d819f7de13b26eb35485be',
     x86_64: '266475bea4c3f138f9d1e894b36cdf1cfafb38db6d69945f41c3bc1ac11f70d3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses'
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
