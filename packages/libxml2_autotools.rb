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
  source_url Libxml2.source_url
  git_hashtag Libxml2.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c4a657d5664cdd2ddc64ad7bab7b1e9c386e9cd2ff017e565c0477aecb6864d',
     armv7l: '7c4a657d5664cdd2ddc64ad7bab7b1e9c386e9cd2ff017e565c0477aecb6864d',
       i686: '141c1adb6bcffa3ae4c5900c0b764647bce4e11b76c1cc8d527eabb1b2ad4071',
     x86_64: '5cdd131dfaba8ad01089fad708b8a4cf036dad67864966c2ea604c58822a2a3e'
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
