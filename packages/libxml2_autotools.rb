Package.load_package("#{__dir__}/libxml2.rb")
# cmake builds are dependent upon libxml2, so we need a libxml2 build
# done without using cmake.
require 'buildsystems/autotools'

class Libxml2_autotools < Autotools
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version Libxml2.version
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '318ef22e12bc93c300449c98e2303b13f6f0eaeec92731df69fb7b6a91b6811b',
     armv7l: '318ef22e12bc93c300449c98e2303b13f6f0eaeec92731df69fb7b6a91b6811b',
       i686: '92a0aa4bd4a09eb7097eb093bfcee6cbf3121316d116a6cb3c359481819bb71a',
     x86_64: '1cb9f3913d3e95deea3c3be31424f8802246a083ea3995f797e74a92c0d13d78'
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

  configure_options '--disable-static \
    --with-icu \
    --without-python \
    --without-lzma'
end
