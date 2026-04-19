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
    aarch64: 'c5638b1d109d1f5e3dccf1c9f3e0efb7d395ac82df8e3378db1f2f38d1f61c19',
     armv7l: 'c5638b1d109d1f5e3dccf1c9f3e0efb7d395ac82df8e3378db1f2f38d1f61c19',
       i686: 'f36810b6a46d241a42de5610bec6708dc42e76ff5bb79570433b75c76e41cf21',
     x86_64: '383cd12bcb55c99e9a8d24fb08d3ef0192c5e306f1bde3f3d42a4bdcc8ed71f7'
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
