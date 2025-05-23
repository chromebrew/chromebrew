# Meson builds of 2.13.x need a patch.
# See https://gitlab.gnome.org/GNOME/libxml2/-/issues/923
require 'buildsystems/cmake'

class Libxml2 < CMake
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  # Versions newer than 2.13.x require everything to be recompiled.
  version "2.13.7-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ef7210db33741e6fbd387794968bff197af8bd66c16933cecd05c5605b8d4c0',
     armv7l: '1ef7210db33741e6fbd387794968bff197af8bd66c16933cecd05c5605b8d4c0',
       i686: '306413b748948807f4ac79cc3869faef99f8236d8b8ade48b32ecaa3fdf979f1',
     x86_64: '1c9a1de8bfd0fff674257736ed362c7382321c5e5c4c4e5cf37abd37762bb87b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'readline' # R

  conflicts_ok
  gnome

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    # system "for f in $(grep -rl 'TRUE)'); do sed -i 's,TRUE),true),g' $f; done"
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    # FileUtils.rm 'test/ebcdic_566012.xml'
  end

  cmake_options '-DLIBXML2_WITH_PYTHON=OFF \
    -DLIBXML2_WITH_LZMA=OFF \
    -DLIBXML2_WITH_ICU=ON'
end
