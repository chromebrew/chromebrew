require 'buildsystems/cmake'

class Libxml2 < CMake
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version "2.14.5-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21c6bc3930aae3b7ded70c46af3efb63ac417cc8443a99eb055d4c34617244cb',
     armv7l: '21c6bc3930aae3b7ded70c46af3efb63ac417cc8443a99eb055d4c34617244cb',
       i686: '2587ae24f5e8c00c51b8ca3e8441465a9bdd17b529d78cd92812d9bd77366c74',
     x86_64: '1f7c6233a0bd80aa246ae0ea3e4890cba34dada2959163ffefd25f0bd4ed7015'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
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

  cmake_options '-DLIBXML2_WITH_PYTHON=OFF \
    -DLIBXML2_WITH_LZMA=OFF \
    -DLIBXML2_WITH_ICU=ON'
end
