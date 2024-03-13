require 'buildsystems/autotools'

class Libxml2 < Autotools
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.12.5-icu74.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.12.5/libxml2-v2.12.5.tar.bz2'
  source_sha256 '6ac1511e1f659940708254c430b51a7ba6b88a8d1d46b03e5a1e0e264bd87679'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77dce5287d36803131e59f1e26b999812c2fdd3cbde52e1fea6a532fca2f51f1',
     armv7l: '77dce5287d36803131e59f1e26b999812c2fdd3cbde52e1fea6a532fca2f51f1',
       i686: 'edc340c49ab96eac98150297b9604e545c153108346b45091acc2c02eb364c71',
     x86_64: '3fd4e2262836228624e2de226889993be7561d133cdc7e51010ae21e78a721ab'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in $(grep -rl 'TRUE)'); do sed -i 's,TRUE),true),g' $f; done"
  end

  configure_options '--enable-shared \
      --enable-static \
      --with-pic \
      --without-python \
      --without-lzma \
      --with-zlib \
      --with-icu \
      --with-threads \
      --with-history'

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system 'rm', 'test/ebcdic_566012.xml'

    system 'make', 'check'
  end
end
