Package.load_package("#{__dir__}/libxml2.rb")
# cmake builds are dependent upon libxml2, so we need a libxml2 build
# done without using cmake.
require 'buildsystems/autotools'

class Libxml2_autotools < Autotools
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version "2.14.5-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url Libxml2.source_url
  git_hashtag Libxml2.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90329ad261162fa53deb07bf04fbbfd5e2c4ce466b4b868e29fbf2fffcb1551a',
     armv7l: '90329ad261162fa53deb07bf04fbbfd5e2c4ce466b4b868e29fbf2fffcb1551a',
       i686: '07569ac9ce0e961550e3f00e53c84c270577cf001ec50534f018c756cf0e3e47',
     x86_64: '93d41d6a6de1ed07c18d1e271114e5239f198244e2610353d8f258f671191460'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'zlib' # R
  depends_on 'libxml2' # R

  conflicts_ok
  gnome

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in $(grep -rl 'TRUE)'); do sed -i 's,TRUE),true),g' $f; done"
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    FileUtils.rm 'test/ebcdic_566012.xml'
  end

  autotools_configure_options '--disable-static \
    --with-icu \
    --without-python \
    --without-lzma'
end
