require 'buildsystems/cmake'

class Libxml2 < CMake
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.12.6-icu74.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.12.6/libxml2-v2.12.6.tar.bz2'
  source_sha256 '69f08b81d4532d285ceea4cdb017eb2d948cb87c34c1d64248a92be90e84132d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4214df62d178e10c6254541a1aebf9c5df77914d5f41cdcc8f6a6841439a76c',
     armv7l: 'a4214df62d178e10c6254541a1aebf9c5df77914d5f41cdcc8f6a6841439a76c',
       i686: '62f44c0ebcc1a37a4ef38f069f645795ddeaa89707962bff617c4de348884755',
     x86_64: '7a1f6e5704b59ff0a535a2aa4c245be9dc038bd59dd4d581d6ce2eddf94bcaca'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R

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
