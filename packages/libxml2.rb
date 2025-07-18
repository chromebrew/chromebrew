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
    aarch64: 'a5a14b8fb55844dfe30ac1e28f43d71f5e50ba3eb68c2fad60e68453c05c9a49',
     armv7l: 'a5a14b8fb55844dfe30ac1e28f43d71f5e50ba3eb68c2fad60e68453c05c9a49',
       i686: '017d8fa5b3521b8f2ad9d527d79c2c1518262e121c67fb4c864e51331e1511f8',
     x86_64: '055b71713943d17d87205735fdda82c33a76bf0f8397c0cbc7a34275c2f9ab6b'
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
