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
    aarch64: '9354f48a6b692dab62855f510a90b362bdc5565b85daa5cea79eea36b2d9abd6',
     armv7l: '9354f48a6b692dab62855f510a90b362bdc5565b85daa5cea79eea36b2d9abd6',
       i686: 'a04f24e2725c13bdd61c618603f7e1cea10e2f01b0116e0e4658e9af9996ba88',
     x86_64: '31e2112b80a4d5577a2123fe2d36d3a8b3f15fc7d2b3519a84325682f07d8198'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'zlib' # R

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
