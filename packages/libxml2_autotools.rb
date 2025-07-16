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
    aarch64: 'e686b597416d51b4118a910033fa71748db2f7bae97858306a29119aefa86f4e',
     armv7l: 'e686b597416d51b4118a910033fa71748db2f7bae97858306a29119aefa86f4e',
       i686: '90bc0e31787a59c96fc1e563c4622aa6597e870f0ff2aa5f8b6b84a4087282e1',
     x86_64: 'b5ba490429312ceaf3ae96f7b6944e3c45f3f18edf8acc3599d96f9cf33fa62f'
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
