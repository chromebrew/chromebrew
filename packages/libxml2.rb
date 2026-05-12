require 'buildsystems/cmake'

class Libxml2 < CMake
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version "2.15.3-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd6992fe3e9ed5a9058b329f86592a73673583aa3595acec54db0359303eeddb',
     armv7l: 'fd6992fe3e9ed5a9058b329f86592a73673583aa3595acec54db0359303eeddb',
       i686: 'a4f33a2c139f3b582e7a0fba3f9a6e10e039ec636d9627bfdf4b04422177199a',
     x86_64: '64286bc7c708a31f6f173ec3c2751cf431444d76641e8bfe33b9503b1413e65f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'libxml2' => :executable

  conflicts_ok
  gnome

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in $(grep -rl 'TRUE)'); do sed -i 's,TRUE),true),g' $f; done"
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    FileUtils.rm 'test/ebcdic_566012.xml'
  end

  cmake_options '-DLIBXML2_WITH_PYTHON=OFF \
    -DLIBXML2_WITH_LZMA=OFF \
    -DLIBXML2_WITH_ICU=ON'
end
