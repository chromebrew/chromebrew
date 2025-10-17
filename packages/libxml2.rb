require 'buildsystems/cmake'

class Libxml2 < CMake
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version "2.15.1-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60fc8c763f04645d76f52d61a7e82e7156a752605e5f594e253836ebb86b02f1',
     armv7l: '60fc8c763f04645d76f52d61a7e82e7156a752605e5f594e253836ebb86b02f1',
       i686: '7910667c0e52a7ff2b922a022affbb664c8c612ccdfe3279304cd99d998e6d4f',
     x86_64: 'd2a56d4e78b64e776e2975c0b4c9103317cc8c913a64c71a6dcf0c1e620c9893'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R

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
