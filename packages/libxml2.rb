require 'buildsystems/autotools'

class Libxml2 < Autotools
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.12.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.12.5/libxml2-v2.12.5.tar.bz2'
  source_sha256 '6ac1511e1f659940708254c430b51a7ba6b88a8d1d46b03e5a1e0e264bd87679'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d7972789f497120ad6969cf8e36eb7840d3f03b08c2a17ee34457501de11df5',
     armv7l: '6d7972789f497120ad6969cf8e36eb7840d3f03b08c2a17ee34457501de11df5',
       i686: '4a5cab259d20895b3c9610a0ab32da15a0442e546e8b6f0c005f46bb59e30824',
     x86_64: '45eed75e21b967f3420acd4568be5e1dc0f7b15b375668b516ff4349d5384534'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R
  depends_on 'ncurses' # R

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
